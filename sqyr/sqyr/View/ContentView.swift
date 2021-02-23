//
//  ContentView.swift
//  sqyr
//
//  Created by David Barsamian, Lauren Nelson, Steven Phun, True Sarmiento, and Tomas Perez on 1/27/21.

import ARKit_CoreLocation
import CoreLocation
import Drawer
import SwiftUI

struct ContentView: View {
    var sceneLocationView = SceneLocationView()

    var body: some View {
        ZStack {
            ARMapView()
                .edgesIgnoringSafeArea(.all)
            GeometryReader { geo in
                Drawer(heights: Binding<[CGFloat]>.constant([200, UIScreen.main.bounds.height - geo.safeAreaInsets.top]), startingHeight: 200) {
                    ZStack {
                        // Background
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.white)
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
                .edgesIgnoringSafeArea(.vertical)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
