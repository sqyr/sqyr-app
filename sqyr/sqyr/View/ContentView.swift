//
//  ContentView.swift
//  sqyr
//
//  Created by David Barsamian, Lauren Nelson, Steven Phun, True Sarmiento, and Tomas Perez on 1/27/21.

import SwiftUI
import PermissionsSwiftUI

// MARK: - View

struct ContentView: View {
    @State private var showingDrawer: Bool = true
    @State private var showingOnboarding: Bool = false
    @State private var showingPermissions: Bool = false
    @State private var showingAR: Bool = false // TODO: change this based on permissions granted
    @State private var appVersion: String? = UserDefaults.standard.string(forKey: "appVersion")

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
                ARCLView()
                    .edgesIgnoringSafeArea(.all)
                    .gesture(resignFRGesture, including: .all)
                    .background(Color(UIColor.systemBackground))
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
        .onAppear {
            checkForUpdate()
            showingAR = true
        }
        .fullScreenCover(isPresented: $showingOnboarding, content: {
            OnboardingView()
        })
        .JMModal(showModal: $showingPermissions, for: [.camera, .location])
        .setPermissionComponent(for: .camera, description: "Sqyr needs to overlay an augmented reality guide over your camera.")
        .setPermissionComponent(for: .location, description: "Sqyr needs to get your location to display relevant landmark guides.")
        .changeBottomDescriptionTo("Sqyr needs these permissions for all the features and functionality to work. Without camera permission, you can't see the augmented reality guide. Without location permision, you can't get accurate guidance to locations.")
        .setAccentColor(to: .accentColor)
    }
    
    private func checkForUpdate() {
        let currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        
        if self.appVersion == nil {
            self.showingOnboarding = true
            UserDefaults.standard.set(currentVersion, forKey: "appVersion")
            self.appVersion = currentVersion
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
