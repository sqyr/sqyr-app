//
//  SearchBarRepresentable.swift
//  sqyr
//
//  Created by David Barsamian on 2/22/21.
//

import Foundation
import UIKit
import SwiftUI

// MARK: - View Representable
struct SearchBarView: UIViewRepresentable {
    @Binding var text: String
    @ObservedObject var model: GlobalModel
    
    // MARK: - Coordinator
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        @ObservedObject var model: GlobalModel
        
        init(text: Binding<String>, globalModel: GlobalModel) {
            _text = text
            self.model = globalModel
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            if !searchText.isEmpty {
                searchBar.setShowsCancelButton(true, animated: true)
            } else {
                searchBar.setShowsCancelButton(false, animated: true)
            }
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            print("SearchBarView: cancel button clicked")
            searchBar.showsCancelButton = false
            searchBar.text = ""
            text = searchBar.text ?? ""
            searchBar.resignFirstResponder()
            model.searchBarIsEditing = false
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            // TODO: Use GlobalModel to broadcast when search bar begins editing
            model.searchBarIsEditing = true
            print("SearchBarView: is editing")
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            // TODO: Use GlobalModel to broadcast when search bar ends editing
            model.searchBarIsEditing = false
            print("SearchBarView: is no longer editing")
        }
    }
    
    // MARK: - Protocol Methods
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, globalModel: model)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBarView>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search for a place"
//        searchBar.isTranslucent = true
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBarView>) {
        uiView.text = text
    }
}
