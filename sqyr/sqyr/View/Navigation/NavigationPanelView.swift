//
//  NavigationPanelView.swift
//  sqyr
//
//  Created by Steven Phun on 2/10/21.
//

import SwiftUI

struct NavigationPanelView: View {
    // States
    @State private var categorySelection: Category = .all
    @State private var text: String = ""
    @State private var landmarks = [Landmark]()
    
    // Observed
    @ObservedObject var globalModel: GlobalModel

    init(globalModel: GlobalModel) {
        self.globalModel = globalModel
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color("gold"))], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.white)], for: .normal)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("gold"))]
        
        HTTPLandmarkClient.shared.getAllLandmarks()
        if let array = HTTPLandmarkClient.shared.landMarks {
            landmarks = array
        }
    }
    
    func landmarksFiltered() -> [Landmark] {
        switch categorySelection {
        case .all:
            return helpFilterLandmarks(in: .all)
        case .academic:
            return helpFilterLandmarks(in: .academic)
        case .food:
            return helpFilterLandmarks(in: .food)
        case .house:
            return helpFilterLandmarks(in: .house)
        case .social:
            return helpFilterLandmarks(in: .social)
        }
    }
    
    func helpFilterLandmarks(in category: Category) -> [Landmark] {
        let filteredLandmarks = landmarks.filter { (landmark) -> Bool in
            
        }
        
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
