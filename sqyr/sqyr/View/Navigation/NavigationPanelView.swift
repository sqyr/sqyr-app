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
    
    // Observed
    @ObservedObject var globalModel: GlobalModel
    @ObservedObject var httpClient: HTTPLandmarkClient

    init(globalModel: GlobalModel) {
        self.globalModel = globalModel
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color("gold"))], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.white)], for: .normal)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("gold"))]
        
        httpClient = HTTPLandmarkClient.shared
        httpClient.getAllLandmarks()
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
        guard let landmarks = httpClient.landMarks else { return [] }
        let filteredLandmarks = landmarks.filter { (landmark) -> Bool in
            if let type = landmark.buildingType, (type.lowercased() == category.rawValue.lowercased() || categorySelection == .all) {
                return true
            } else {
                return false
            }
        }
        return filteredLandmarks.sorted { (firstLandmark, secondLandmark) -> Bool in
            return firstLandmark.landMarkName ?? "" < secondLandmark.landMarkName ?? ""
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
                        NavigationLink(destination: LandmarkDetail(with: landmark, classRooms: landmark.classRoomsId ?? nil)) {
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
    let landmark: Landmark
    
    var body: some View {
        HStack {
            Image(systemName: landmark.icon ?? "")
                .font(.title2)
            
            VStack(alignment: .leading) {
                Text(landmark.landMarkName ?? "")
                    .fontWeight(.bold)
                    .foregroundColor(Color("blue"))
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
