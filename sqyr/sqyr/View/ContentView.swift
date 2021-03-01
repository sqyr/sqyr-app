//
//  ContentView.swift
//  sqyr
//
//  Created by David Barsamian, Lauren Nelson, Steven Phun, True Sarmiento, and Tomas Perez on 1/27/21.

import ARKit_CoreLocation
import CoreLocation
import SwiftUI

struct ContentView: View {
    @State var drawerHeights: [CGFloat] = [200]
    @State var showingDrawer: Bool = true
    @State var showingPermAlert: Bool = true

    var sceneLocationView = SceneLocationView()

    var body: some View {
        ZStack {
            ARView()
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    dismissKeyboard()
                }
            GeometryReader { geo in
                NavigationDrawer(geoProxy: geo)
            }
        }
        .JMAlert(showModal: $showingPermAlert, for: [.camera, .location], autoDismiss: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
