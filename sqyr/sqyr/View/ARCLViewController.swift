//
//  ARCLViewController.swift
//  sqyr
//
//  Created by David Barsamian on 2/1/21.
//

import Foundation
import UIKit
import ARKit_CoreLocation
import CoreLocation

class ARCLViewController: UIViewController {
    var sceneLocationView = SceneLocationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
        
        // Apple Park
        var coordinate = CLLocationCoordinate2D(latitude: 37.3326, longitude: -122.0055)
        var location = CLLocation(coordinate: coordinate, altitude: 200)
        var image = UIImage(systemName: "mappin")!
        var annotationNode = LocationAnnotationNode(location: location, image: image)
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        
        // CBU
        coordinate = CLLocationCoordinate2D(latitude: 33.9289, longitude: -117.4259)
        location = CLLocation(coordinate: coordinate, altitude: 200)
        image = UIImage(systemName: "mappin")!.withTintColor(.systemBlue).resizableImage(withCapInsets: .zero)
        annotationNode = LocationAnnotationNode(location: location, image: image)
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        
    }
}
