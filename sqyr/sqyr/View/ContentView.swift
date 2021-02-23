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
    @State var drawerHeights: [CGFloat] = [200]

    var sceneLocationView = SceneLocationView()

    var body: some View {
        ZStack {
            ARMapView()
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    dismissKeyboard()
                }
            GeometryReader { geo in
                // Binding<[CGFloat]>.constant([200, UIScreen.main.bounds.height - geo.safeAreaInsets.top]
                Drawer(heights: $drawerHeights, startingHeight: 200) {
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
                .edgesIgnoringSafeArea(.vertical)
                .onAppear {
                    drawerHeights = [200, UIScreen.main.bounds.height - geo.safeAreaInsets.top]
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
