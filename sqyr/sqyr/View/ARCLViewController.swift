//
//  ARCLViewController.swift
//  sqyr
//
//  Created by David Barsamian on 2/1/21.
//

import ARKit_CoreLocation
import CoreLocation
import Foundation
import UIKit

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
        var nodes: [LocationAnnotationNode] = []
        nodes.append(buildNode(lat: 37.3326, long: -122.0055, altitude: 200, image: UIImage(systemName: "mappin")!))
        
        // CBU
        nodes.append(buildNode(lat: 33.9289, long: -117.4259, altitude: 200, image: UIImage(systemName: "mappin")!))
        
        sceneLocationView.addLocationNodesWithConfirmedLocation(locationNodes: nodes)
    }
    
    /// Returns a new LocationAnnotationNode with the inputted parameters
    /// - Parameter lat: The latitude of the location
    /// - Parameter long: The longitude of the location
    /// - Parameter altitude: The altitude of the location
    /// - Parameter image: The image to display for the node
    private func buildNode(lat: CLLocationDegrees, long: CLLocationDegrees, altitude: CLLocationDistance, image: UIImage) -> LocationAnnotationNode {
        let coord = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let location = CLLocation(coordinate: coord, altitude: altitude)
        return LocationAnnotationNode(location: location, image: image)
    }
}
