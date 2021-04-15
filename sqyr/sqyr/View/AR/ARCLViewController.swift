//
//  ARCLViewController.swift
//  sqyr
//
//  Created by David Barsamian on 2/1/21.
//

import ARKit
import ARKit_CoreLocation
import Combine
import CoreLocation
import Foundation
import UIKit

class ARCLViewController: UIViewController {
    var sceneLocationView = SceneLocationView()
    var coachingOverlay = ARCoachingOverlayView()
    
    var landmarkSubscriber: AnyCancellable?
    var landmarks: [Landmark]?
    
    let pinView: UIView = UIView()
    var landmarkTitles = [CLLocation: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate setup
        sceneLocationView.locationNodeTouchDelegate = self
        
        // Susbcriber setup
        landmarkSubscriber = HTTPLandmarkClient.shared.landmarkPublisher.assign(to: \.landmarks, on: self)
        
        // View setup
        pinView.addSubview(UIImageView(image: UIImage(systemName: "mappin.circle.fill")?.withTintColor(.red)))
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
        view.addSubview(coachingOverlay)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
        
        if let landmarks = landmarks {
            for landmark in landmarks {
                let coordinate = CLLocationCoordinate2D(latitude: landmark.coordinatesLat!, longitude: landmark.coordinatesLon!)
                let location = CLLocation(coordinate: coordinate, altitude: 200)
                let labelledView = UIView.prettyLabelledView(text: landmark.landMarkName!)
                let annotationNode = LocationAnnotationNode(location: location, view: labelledView)
                landmarkTitles[location] = landmark.landMarkName!
                annotationNode.ignoreAltitude = true
                annotationNode.scaleRelativeToDistance = true
                sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
            }
        }
        
        coachingOverlay.session = sceneLocationView.session
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coachingOverlay.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coachingOverlay.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            coachingOverlay.widthAnchor.constraint(equalTo: view.widthAnchor),
            coachingOverlay.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        coachingOverlay.activatesAutomatically = true
        coachingOverlay.goal = .horizontalPlane
    }
}

extension ARCLViewController: LNTouchDelegate {
    
    
    func annotationNodeTouched(node: AnnotationNode) {}
    
    func locationNodeTouched(node: LocationNode) {
        
    }
}

extension UIView {
    // ARCL/Node Demos/ARCLViewController.swift
    class func prettyLabelledView(text: String, backgroundColor: UIColor = .systemBackground, borderColor: UIColor = .black) -> UIView {
        let font = UIFont.preferredFont(forTextStyle: .title2)
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: fontAttributes)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let attributedString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: font])
        label.attributedText = attributedString
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        
        let cframe = CGRect(x: 0, y: 0, width: label.frame.width + 20, height: label.frame.height + 10)
        let cview = UIView(frame: cframe)
        cview.translatesAutoresizingMaskIntoConstraints = false
        cview.layer.cornerRadius = 10
        cview.layer.backgroundColor = backgroundColor.cgColor
        cview.layer.borderColor = borderColor.cgColor
        cview.layer.borderWidth = 1
        cview.addSubview(label)
        label.center = cview.center
        
        return cview
    }
}
