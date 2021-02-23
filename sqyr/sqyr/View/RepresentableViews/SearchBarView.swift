//
//  SearchBarRepresentable.swift
//  sqyr
//
//  Created by David Barsamian on 2/22/21.
//

import Foundation
import UIKit
import SwiftUI

struct SearchBarView: UIViewRepresentable {
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
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
            searchBar.text = ""
            searchBar.setShowsCancelButton(false, animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBarView>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .default
        searchBar.placeholder = "Search for a place"
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBarView>) {
        uiView.text = text
    }
}
