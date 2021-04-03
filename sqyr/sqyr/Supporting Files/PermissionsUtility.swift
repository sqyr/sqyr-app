//
//  Permissions.swift
//  sqyr
//
//  Created by David Barsamian on 3/1/21.
//

import Foundation
import CoreLocation
import AVFoundation
import PermissionsSwiftUI
import SwiftUI

final class PermissionsUtility {
    static func checkPermission(for permission: PermissionType) -> Bool {
        switch permission {
        case .camera:
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                return true
            default: return false
            }
        case .location:
            let locationManager = CLLocationManager()
            switch locationManager.authorizationStatus {
            case .authorizedWhenInUse: return true
            default: return false
            }
        case .locationAlways:
            let locationManager = CLLocationManager()
            switch locationManager.authorizationStatus {
            case.authorizedAlways: return true
            default: return false
            }
        default: return false
        }
        
    }
}
