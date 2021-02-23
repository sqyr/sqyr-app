//
//  ViewExtension.swift
//  sqyr
//
//  Created by David Barsamian on 2/22/21.
//

import Foundation
import UIKit
import SwiftUI

#if canImport(UIKit)
extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
