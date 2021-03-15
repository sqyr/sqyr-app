//
//  ContentView.swift
//  sqyr
//
//  Created by David Barsamian, Lauren Nelson, Steven Phun, True Sarmiento, and Tomas Perez on 1/27/21.

import PermissionsSwiftUI
import SwiftUI
// lol imagine coding lol
// MARK: - View

struct ContentView: View {
    @State var showingDrawer: Bool = true
    @State var showingOnboarding: Bool = true
    @State var showingAR: Bool = false // TODO: change this based on permissions granted

    @ObservedObject var globalModel = GlobalModel()

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        // MARK: - Gestures

        let resignFRGesture = TapGesture().onEnded {
            resignFirstResponder()
        }

        // MARK: - Views

        ZStack {
            if showingAR {
                ARView()
                    .edgesIgnoringSafeArea(.all)
                    .gesture(resignFRGesture, including: .all)
                    .animation(.easeIn)
            }
            GeometryReader { geo in
                NavigationDrawer(geoProxy: geo, globalModel: globalModel)
                Rectangle() // Status Bar Blur
                    .frame(width: geo.size.width, height: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0, alignment: .top)
                    .foregroundColor(.clear)
                    .background(EffectViewRepresentable(effect: UIBlurEffect(style: .systemThinMaterial)))
                    .edgesIgnoringSafeArea(.top)
            }
        }
        .fullScreenCover(isPresented: $showingOnboarding, content: {
            OnboardingView()
                .onDisappear {
                    showingAR = true
                }
        })
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
