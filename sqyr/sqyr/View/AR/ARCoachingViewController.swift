//
//  ARCoachingViewController.swift
//  sqyr
//
//  Created by David Barsamian on 3/18/21.
//

import ARKit
import Foundation
import UIKit

class ARCoachingViewController: UIViewController {
    var goal: ARCoachingOverlayView.Goal
    var coachingOverlay = ARCoachingOverlayView()
    
    init(goal: ARCoachingOverlayView.Goal) {
        self.goal = goal
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.goal = .tracking
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coachingOverlay.activatesAutomatically = false
        view.addSubview(coachingOverlay)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        coachingOverlay.goal = goal
    }
}
