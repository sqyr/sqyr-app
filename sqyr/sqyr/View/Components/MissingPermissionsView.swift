//
//  MissingPermissionsView.swift
//  sqyr
//
//  Created by David Barsamian on 4/2/21.
//

import SwiftUI

struct MissingPermissionsView: View {
    @State private var showingAlert = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 16.0) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 48.0, height: 48.0)
                .foregroundColor(.red)
            Text("There are one or more denied permissions, which will disable some features of the app.")
                .font(.title2)
                .multilineTextAlignment(.center)
            Group {
                Text("Go to ") + Text("Settings").bold() + Text(" and scroll down to find ") + Text("Sqyr").bold() + Text(", and make sure both ") + Text("Location and Camera").bold() + Text(" permissions are enabled.")
            }
            .multilineTextAlignment(.center)
            Button("Open Settings") {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl) { _ in }
                } else {
                    showingAlert = true
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text("Couldn't open Settings. Try again, or go manually to the Settings app."), dismissButton: .cancel())
            }
        }
        .padding()
    }
}

struct MissingPermissionsView_Previews: PreviewProvider {
    static var previews: some View {
        MissingPermissionsView()
    }
}
