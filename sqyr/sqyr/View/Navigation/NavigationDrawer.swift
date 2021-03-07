//
//  NavigationDrawer.swift
//  sqyr
//
//  Created by David Barsamian on 2/28/21.
//

import BottomSheet
import Drawer
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
        EmptyView()
            .bottomSheet(bottomSheetPosition: $bottomSheetPosition, resizeable: true, headerContent: {
                SearchBarView(text: $searchText, model: globalModel)
            }, mainContent: {
                NavigationPanelView(globalModel: globalModel)
            })
            .onChange(of: globalModel.searchBarIsEditing, perform: { _ in
                if globalModel.searchBarIsEditing {
                    bottomSheetPosition = .top
                }
            })
    }
}

@available(*, deprecated, message: "This will be removed in a future version. Use a bottomSheet view modifier instead.")
private struct DrawerContent: View {
    var geoProxy: GeometryProxy
    @State var heights: [CGFloat]
    @ObservedObject var globalModel: GlobalModel

    var body: some View {
        return Drawer(heights: $heights) {
            ZStack {
                // Background
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .shadow(radius: 100)

                // Content
                NavigationPanelView(globalModel: globalModel)
                    .padding(.vertical)

                // Grey Pill Indicator
                VStack(alignment: .center) {
                    Spacer().frame(height: 4.0)
                    RoundedRectangle(cornerRadius: 3.0)
                        .foregroundColor(Color.gray.opacity(0.5))
                        .frame(width: 40.0, height: 6.0)
                    Spacer()
                }
            }
        }
        .impact(.medium)
    }
}
