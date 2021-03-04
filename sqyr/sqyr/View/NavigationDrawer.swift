//
//  NavigationDrawer.swift
//  sqyr
//
//  Created by David Barsamian on 2/28/21.
//

import Drawer
import BottomSheet
import SwiftUI

struct NavigationDrawer: View {
    var geoProxy: GeometryProxy
    @State private var heights: [CGFloat] = [80]
    @State private var bottomSheetPosition: BottomSheetPosition = BottomSheetPosition.bottom
    @State private var searchText: String = ""
    @ObservedObject var globalModel: GlobalModel

    var body: some View {
//        DrawerContent(geoProxy: geoProxy, heights: heights, globalModel: globalModel)
//            .onReceive(globalModel.objectWillChange) { _ in
//                if globalModel.searchBarIsEditing {
//                    heights = [geoProxy.size.height * 0.9]
//                } else {
//                    heights = [100, geoProxy.size.height * 0.9]
//                }
//            }
        EmptyView()
            .bottomSheet(bottomSheetPosition: $bottomSheetPosition, tapToExpand: true, headerContent: {
                SearchBarView(text: $searchText, globalModel: globalModel)
            }, mainContent: {
                NavigationPanelView(globalModel: globalModel)
            })
    }
}

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
