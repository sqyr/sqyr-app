//
//  GlobalModel.swift
//  sqyr
//
//  Created by David Barsamian on 2/22/21.
//

import Foundation
import Combine

class GlobalModel: ObservableObject {
    @Published var searchBarIsEditing: Bool
    @Published var shouldHideAr: Bool
    
    init() {
        searchBarIsEditing = false
        shouldHideAr = false
    }
}
