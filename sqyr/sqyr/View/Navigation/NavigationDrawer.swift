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
    @State private var landmarks = [Landmark]()
    
    @ObservedObject var globalModel: GlobalModel
    @ObservedObject var httpClient = HTTPLandmarkClient()
    
    init(globalModel: GlobalModel, geoProxy: GeometryProxy) {
        self.globalModel = globalModel
        self.geoProxy = geoProxy
    }

    // MARK: - Views

    var body: some View {
        let resignFRGesture = TapGesture().onEnded {
            resignFirstResponder()
        }
        
        let expandGesture = TapGesture().onEnded {
            bottomSheetPosition = .top
        }
        
        EmptyView()
            .bottomSheet(bottomSheetPosition: $bottomSheetPosition, resizeable: true, headerContent: {
                SearchBarView(text: $searchText, model: globalModel)
            }, mainContent: {
                NavigationPanelView(landmarks: landmarks, globalModel: globalModel, httpClient: httpClient)
                    .gesture(resignFRGesture, including: globalModel.searchBarIsEditing ? .gesture : .none)
                    .gesture(expandGesture, including: bottomSheetPosition == .middle ? .all : .subviews)
            })
            .onChange(of: globalModel.searchBarIsEditing, perform: { _ in
                if globalModel.searchBarIsEditing {
                    bottomSheetPosition = .top
                }
            })
            .onAppear {
                print("onAppear")
                httpClient.getAllLandmarks()
            }
            .onReceive(httpClient.$landMarks) { (output) in
                if let landmarks = output, !landmarks.isEmpty, !self.landmarks.elementsEqual(landmarks) {
                    print("Replacing landmarks...")
                    self.landmarks.removeAll()
                    self.landmarks.append(contentsOf: landmarks)
                    print(self.landmarks)
                } else {
                    httpClient.getAllLandmarks()
                }
            }
    }
}
