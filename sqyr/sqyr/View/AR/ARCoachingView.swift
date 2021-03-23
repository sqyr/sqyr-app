//
//  ARCoachingView.swift
//  sqyr
//
//  Created by David Barsamian on 3/18/21.
//

import SwiftUI
import UIKit

struct ARCoachingView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ARCoachingViewController {
        return ARCoachingViewController(goal: .horizontalPlane)
    }

    func updateUIViewController(_ uiViewController: ARCoachingViewController, context: Context) {}
}
