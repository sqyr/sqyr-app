//
//  sqyrApp.swift
//  sqyr
//
//  Created by David Barsamian, Lauren Nelson, Steven Phun, True Sarmiento, and Tomas Perez on 1/27/21.
//

import SwiftUI

@main
struct sqyrApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationPanelView(globalModel: GlobalModel())
        }
    }
}
