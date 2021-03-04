//
//  QRScannerView.view.swift
//  sqyr
//
//  Created by Lauren Nelson on 2/9/21.
//

import SwiftUI

import Foundation
import AVFoundation

struct ScannerView: View {
    @ObservedObject var viewModel = ScannerViewModel()
    
    var body: some View {
        ZStack {
            Text("Replace me with the actual Scanner...").foregroundColor(Color.white)
            
            
            VStack {
                VStack {
                    Text("Find a QR-code")
                        .font(.subheadline).foregroundColor(Color.white)
                    Text(self.viewModel.lastQrCode)
                        .bold()
                        .lineLimit(5)
                        .padding()
                }
                .padding(.vertical, 20)

                Spacer()
                HStack {
                    Button(action: {
                        self.viewModel.torchIsOn.toggle()
                    }, label: {
                        Image(systemName: self.viewModel.torchIsOn ? "bolt.fill" : "bolt.slash.fill")
                            .imageScale(.large)
                            .foregroundColor(self.viewModel.torchIsOn ? Color.yellow : Color.blue)
                            .padding()
                    })
                }
                .background(Color.white)
                .cornerRadius(10)
                
            }.padding()
        }
    }
}

class QrCodeCameraDelegate: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    
    var scanInterval: Double = 1.0
    var lastTime = Date(timeIntervalSince1970: 0)
    
    var onResult: (String) -> Void = { _  in }
    var mockData: String?
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            foundBarcode(stringValue)
        }
    }
    
    @objc func onSimulateScanning(){
        foundBarcode(mockData ?? "Simulated QR-code result.")
    }
    
    func foundBarcode(_ stringValue: String) {
        let now = Date()
        if now.timeIntervalSince(lastTime) >= scanInterval {
            lastTime = now
            self.onResult(stringValue)
        }
    }
}

struct QrCodeScannerView: UIViewRepresentable {
    
    var supportedBarcodeTypes: [AVMetadataObject.ObjectType] = [.qr]
    typealias UIViewType = CameraPreview
    
    private let session = AVCaptureSession()
    private let delegate = QrCodeCameraDelegate()
    private let metadataOutput = AVCaptureMetadataOutput()
    
    
    func torchLight(isOn: Bool) -> QrCodeScannerView {
        if let backCamera = AVCaptureDevice.default(for: AVMediaType.video) {
            if backCamera.hasTorch {
                try? backCamera.lockForConfiguration()
                if isOn {
                    backCamera.torchMode = .on
                } else {
                    backCamera.torchMode = .off
                }
                backCamera.unlockForConfiguration()
            }
        }
        return self
    }
    
    func interval(delay: Double) -> QrCodeScannerView {
        delegate.scanInterval = delay
        return self
    }
    
    func found(r: @escaping (String) -> Void) -> QrCodeScannerView {
        delegate.onResult = r
        return self
    }
    
    func simulator(mockBarCode: String)-> QrCodeScannerView{
        delegate.mockData = mockBarCode
        return self
    }
    
    func setupCamera(_ uiView: CameraPreview) {
        if let backCamera = AVCaptureDevice.default(for: AVMediaType.video) {
            if let input = try? AVCaptureDeviceInput(device: backCamera) {
                session.sessionPreset = .photo
                
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(metadataOutput) {
                    session.addOutput(metadataOutput)
                    
                    metadataOutput.metadataObjectTypes = supportedBarcodeTypes
                    metadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
                }
                let previewLayer = AVCaptureVideoPreviewLayer(session: session)
                
                uiView.backgroundColor = UIColor.gray
                previewLayer.videoGravity = .resizeAspectFill
                uiView.layer.addSublayer(previewLayer)
                uiView.previewLayer = previewLayer
                
                session.startRunning()
            }
        }
        
    }
    
    func makeUIView(context: UIViewRepresentableContext<QrCodeScannerView>) -> QrCodeScannerView.UIViewType {
        let cameraView = CameraPreview(session: session)
        
        #if targetEnvironment(simulator)
        cameraView.createSimulatorView(delegate: self.delegate)
        #else
        checkCameraAuthorizationStatus(cameraView)
        #endif
        
        return cameraView
    }
    
    static func dismantleUIView(_ uiView: CameraPreview, coordinator: ()) {
        uiView.session.stopRunning()
    }
    
    private func checkCameraAuthorizationStatus(_ uiView: CameraPreview) {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if cameraAuthorizationStatus == .authorized {
            setupCamera(uiView)
        } else {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.sync {
                    if granted {
                        self.setupCamera(uiView)
                    }
                }
            }
        }
    }
    
    func updateUIView(_ uiView: CameraPreview, context: UIViewRepresentableContext<QrCodeScannerView>) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
}

class CameraPreview: UIView {
    
    private var label:UILabel?
    
    var previewLayer: AVCaptureVideoPreviewLayer?
    var session = AVCaptureSession()
    weak var delegate: QrCodeCameraDelegate?
    
    init(session: AVCaptureSession) {
        super.init(frame: .zero)
        self.session = session
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSimulatorView(delegate: QrCodeCameraDelegate){
        self.delegate = delegate
        self.backgroundColor = UIColor.black
        label = UILabel(frame: self.bounds)
        label?.numberOfLines = 4
        label?.text = "Click here to simulate scan"
        label?.textColor = UIColor.white
        label?.textAlignment = .center
        if let label = label {
            addSubview(label)
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onClick))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func onClick(){
        delegate?.onSimulateScanning()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        #if targetEnvironment(simulator)
            label?.frame = self.bounds
        #else
            previewLayer?.frame = self.bounds
        #endif
    }
}

class ScannerViewModel: ObservableObject {

    /// Defines how often we are going to try looking for a new QR-code in the camera feed.
    let scanInterval: Double = 1.0

    @Published var torchIsOn: Bool = false
    @Published var lastQrCode: String = "Qr-code goes here"


    func onFoundQrCode(_ code: String) {
        self.lastQrCode = code
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            QrCodeScannerView()
            ScannerView()
        }
    }
}
