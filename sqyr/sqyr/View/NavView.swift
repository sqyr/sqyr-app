//
//  NavigationView.swift
//  sqyr
//
//  Created by Lauren Nelson on 2/15/21.
//

import Foundation
import UIKit
import ARKit_CoreLocation
import CoreLocation
import SwiftUI

struct NavView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                ARMapView()
                NavagationPanelView()
            }
            
        }
    }
}
