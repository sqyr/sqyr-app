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

    init(globalModel: GlobalModel) {
        self.globalModel = globalModel
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color("gold"))], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.white)], for: .normal)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("gold"))]
    }
    
    func landmarksFiltered() -> [LandmarkJson] {
        let landmarkArray: [LandmarkJson] = landmarks

        
        if categorySelection == .social {
            return helpFilterLandmarks(category: "Social")
        }
        
        if categorySelection == .academic {
            return helpFilterLandmarks(category: "Academic")
        }
        
        if categorySelection == .food {
            return helpFilterLandmarks(category: "Food")
        }
        
        if categorySelection == .house {
            return helpFilterLandmarks(category: "Housing")
        }
        
        
        return landmarkArray
    }
    
    func helpFilterLandmarks(category: String) -> [LandmarkJson] {
        var landmarkFilter: [LandmarkJson] = []
        
        for landmark in landmarks {
            if landmark.type == category {
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
                            NavLandmarkListView(landmark: landmark)
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

struct NavLandmarkListView: View {
    let landmark: LandmarkJson
    
    var body: some View {
        HStack {
            Image(systemName: landmark.icon)
                .font(.title2)
            
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .fontWeight(.bold)
                    .foregroundColor(Color("blue"))
            
            Text(landmark.imageSubHeadline)
                .foregroundColor(.secondary)
                .font(.footnote)
            } //: VSTACK
        } //: HSTACK
        .padding(.vertical, 12)
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
            .environmentObject(GlobalModel())
    }
}
