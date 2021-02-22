//
//  ContentView.swift
//  sqyr
//
//  Created by David Barsamian, Lauren Nelson, Steven Phun, True Sarmiento, and Tomas Perez on 1/27/21.
 
import SwiftUI
import CoreLocation
import ARKit_CoreLocation
import Drawer

struct ContentView: View {
    var sceneLocationView = SceneLocationView()
    
    var body: some View {
<<<<<<< HEAD
        return NavView().edgesIgnoringSafeArea(.all)
=======
        ARMapView().edgesIgnoringSafeArea(.all)
>>>>>>> functional-ar-code
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
