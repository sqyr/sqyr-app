//
//  NavigationDrawer.swift
//  sqyr
//
//  Created by David Barsamian on 2/28/21.
//

import BottomSheet
import SwiftUI

// MARK: - View
struct NavigationDrawer: View {
    var geoProxy: GeometryProxy
    @State private var heights: [CGFloat] = [80]
    @State private var bottomSheetPosition = BottomSheetPosition.bottom
    @State private var searchText: String = ""
    @ObservedObject var globalModel: GlobalModel

    // MARK: - Views
    var body: some View {
        let resignFRGesture = TapGesture().onEnded {
            resignFirstResponder()
        }
        
        EmptyView()
            .bottomSheet(bottomSheetPosition: $bottomSheetPosition, resizeable: true, headerContent: {
                SearchBarView(text: $searchText, model: globalModel)
            }, mainContent: {
                NavigationPanelView(globalModel: globalModel)
                    .gesture(resignFRGesture, including: globalModel.searchBarIsEditing ? .gesture : .none)
            })
            .onChange(of: globalModel.searchBarIsEditing, perform: { _ in
                if globalModel.searchBarIsEditing {
                    bottomSheetPosition = .top
                }
            })
            
    }
}
