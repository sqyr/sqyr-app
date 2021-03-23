//
//  ARCLViewController.swift
//  sqyr
//
//  Created by David Barsamian on 2/1/21.
//

import ARKit_CoreLocation
import ARKit
import CoreLocation
import Foundation
import UIKit

class ARCLViewController: UIViewController {
    var sceneLocationView = SceneLocationView()
    var coachingOverlay = ARCoachingOverlayView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(coachingOverlay)
        
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
        
        // Apple Park
        var coordinate = CLLocationCoordinate2D(latitude: 37.3326, longitude: -122.0055)
        var location = CLLocation(coordinate: coordinate, altitude: 200)
        var labelledView = UIView.prettyLabelledView(text: "Apple Park")
        var annotationNode = LocationAnnotationNode(location: location, view: labelledView)
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        
        // CBU
        coordinate = CLLocationCoordinate2D(latitude: 33.9289, longitude: -117.4259)
        location = CLLocation(coordinate: coordinate, altitude: 200)
        labelledView = UIView.prettyLabelledView(text: "California Baptist University")
        annotationNode = LocationAnnotationNode(location: location, view: labelledView)
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        
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
