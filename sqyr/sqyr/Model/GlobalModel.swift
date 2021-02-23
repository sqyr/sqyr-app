//
//  GlobalModel.swift
//  sqyr
//
//  Created by David Barsamian on 2/22/21.
//

import Foundation

class GlobalModel: ObservableObject {
    @Published var searchBarIsEditing: Bool
    
    init() {
        searchBarIsEditing = false
    }
}
