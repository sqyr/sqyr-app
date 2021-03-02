//
//  ContentView.swift
//  sqyr
//
//  Created by David Barsamian, Lauren Nelson, Steven Phun, True Sarmiento, and Tomas Perez on 1/27/21.

import ARKit_CoreLocation
import CoreLocation
import SwiftUI

struct ContentView: View {
    @State var showingDrawer: Bool = true
    @State var showingOnboarding: Bool = true

    @ObservedObject var globalModel = GlobalModel()

    @Environment(\.presentationMode) var presentationMode

    var sceneLocationView = SceneLocationView()

    var body: some View {
        ZStack {
            ARView()
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    dismissKeyboard()
                }
            GeometryReader { geo in
                NavigationDrawer(geoProxy: geo, globalModel: globalModel)
            }
        }
        .sheet(isPresented: $showingOnboarding, content: {
            OnboardingView()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
