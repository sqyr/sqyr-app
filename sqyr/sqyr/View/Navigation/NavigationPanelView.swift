//
//  NavigationPanelView.swift
//  sqyr
//
//  Created by Steven Phun on 2/10/21.
//

import SwiftUI

struct NavigationPanelView: View {
    @State private var categorySelection: Category = .all
    @State private var text: String = ""

    @ObservedObject var globalModel: GlobalModel
    @ObservedObject var httpClient = HTTPLandmarkClient()

    init(globalModel: GlobalModel) {
        self.globalModel = globalModel
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color("gold"))], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.white)], for: .normal)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("gold"))]
    }
    
    func landmarksFiltered() -> [Landmark] {
//        let landmarkArray: [LandmarkJson] = landmarks
        httpClient.getAllLandmarks()
        let landmarkArray: [Landmark] = httpClient.landMarks!
        
        if categorySelection == .social {
            return helpFilterLandmarks(landmarkArray, category: "Social")
        }
        
        if categorySelection == .academic {
            return helpFilterLandmarks(landmarkArray, category: "Academic")
        }
        
        if categorySelection == .food {
            return helpFilterLandmarks(landmarkArray, category: "Food")
        }
        
        if categorySelection == .house {
            return helpFilterLandmarks(landmarkArray, category: "Housing")
        }
        
        return landmarkArray
    }
    
    func helpFilterLandmarks(_ landmarkArray: [Landmark], category: String) -> [Landmark] {
        var landmarkFilter: [Landmark] = []
        
        for landmark in landmarkArray {
            if landmark.buildingType == category {
                landmarkFilter.append(landmark)
            }
        }
        
        return landmarkFilter
    }
        

    var body: some View {
        NavigationView {
            VStack {
                // SearchBarView(text: $text, globalModel: globalModel)

                Picker("Category", selection: $categorySelection) {
                    ForEach(Category.allCases, id: \.self) {
                        Text($0.rawValue)
                            .tag($0.rawValue)
                    }
                } //: PICKER
                .pickerStyle(SegmentedPickerStyle())
                .background(Color("blue"))
                .cornerRadius(8)
                .padding()

                List {
                    ForEach(landmarksFiltered(), id: \.id) { landmark in
                        NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                            HStack {
                                Image(systemName: landmark.icon)
                                    .font(.title2)
                                Text(landmark.landMarkName)
                                    .fontWeight(.bold)
                            } //: HSTACK
                            .foregroundColor(Color("blue"))
                            .padding(.vertical, 12)
                        } //: LINK
                    } //: LOOP
                } //: LIST
                .listStyle(InsetListStyle())
                .padding(.horizontal)

            } //: VSTACK
            .navigationBarTitle("Landmarks")
        } //: NAVIGATION
    }
}

enum Category: String, CaseIterable {
    case all = "All"
    case academic = "Academic"
    case social = "Social"
    case food = "Food"
    case house = "Housing"

    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

struct NavigationPanelView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPanelView(globalModel: GlobalModel())
    }
}
