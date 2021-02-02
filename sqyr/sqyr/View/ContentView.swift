//
//  ContentView.swift
//  sqyr
//
//  Created by David Barsamian, Lauren Nelson, Steven Phun on 1/27/21.

import SwiftUI
import CoreLocation
import ARKit_CoreLocation

struct ContentView: View {
    var sceneLocationView = SceneLocationView()
    
    var body: some View {
        return ARMapView().edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
