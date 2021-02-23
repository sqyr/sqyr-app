//
//  ARMapView.swift
//  sqyr
//
//  Created by David Barsamian on 2/1/21.
//

import SwiftUI
import UIKit
import ARKit_CoreLocation
import CoreLocation

struct ARMapView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ARCLViewController {
        return ARCLViewController()
    }
    
    func updateUIViewController(_ uiViewController: ARCLViewController, context: Context) {}
}
