//
//  ContentView.swift
//  sqyr
//
//  Created by David Barsamian, Lauren Nelson, Steven Phun, True Sarmiento, and Tomas Perez on 1/27/21.

import PermissionsSwiftUI
import SwiftUI

struct ContentView: View {
    @State var showingDrawer: Bool = true
    @State var showingOnboarding: Bool = false
    @State var showingAR: Bool = true // TODO: change this based on permissions granted

    @ObservedObject var globalModel = GlobalModel()

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            ARView()
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    dismissKeyboard()
                }
            GeometryReader { geo in
                NavigationDrawer(geoProxy: geo, globalModel: globalModel)
                Rectangle() // Status Bar Blur
                    .frame(width: geo.size.width, height: UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0, alignment: .top)
                    .foregroundColor(.clear)
                    .background(EffectViewRepresentable(effect: UIBlurEffect(style: .systemUltraThinMaterial)))
                    .edgesIgnoringSafeArea(.top)
            }
        }
        .fullScreenCover(isPresented: $showingOnboarding, content: {
            OnboardingView()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
