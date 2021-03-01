//
//  NavigationDrawer.swift
//  sqyr
//
//  Created by David Barsamian on 2/28/21.
//

import SwiftUI
import Drawer

struct NavigationDrawer: View {
    var geoProxy: GeometryProxy
    
    var body: some View {
        Drawer(heights: Binding<[CGFloat]>.constant([200, geoProxy.size.height * 0.9]), startingHeight: 200.0) {
            ZStack {
                // Background
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .shadow(radius: 100)
                
                // Content
                NavigationPanelView()
                    .padding(.vertical)
                
                // Grey Pill Indicator
                VStack(alignment: .center) {
                    Spacer().frame(height: 4.0)
                    RoundedRectangle(cornerRadius: 3.0)
                        .foregroundColor(Color.gray.opacity(0.5))
                        .frame(width: 40.0, height: 6.0)
                    Spacer()
                }
            }
        }
        .impact(.light)
    }
}
