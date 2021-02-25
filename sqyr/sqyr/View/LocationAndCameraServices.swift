//
//  LocationCameraPermissions.swift
//  sqyr
//
//  Created by Lauren Nelson on 2/22/21.
//

import SwiftUI
import PermissionsSwiftUI

struct LocationCameraPermissions: View {
    @State var showModal = false
    var body: some View {
        Button(action: {
            showModal=true
            }, label: {
                Text("Enable Permissions for app to work")
            })
        .JMAlert(showModal: $showModal, for: [.location, .camera])
        .changeBottomDescriptionTo("Must allow location and camera to use the features of this app")
    }
  }

struct LocationCameraPermissions_Previews: PreviewProvider {
    static var previews: some View {
        LocationCameraPermissions()
    }
}
