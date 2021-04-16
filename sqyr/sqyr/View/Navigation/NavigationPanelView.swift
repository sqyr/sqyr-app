//
//  NavigationPanelView.swift
//  sqyr
//
//  Created by Steven Phun on 2/10/21.
//

import SwiftUI

struct NavigationPanelView: View {
    // States
    var landmarks: [Landmark]
    @State private var categorySelection: Category = .all
    @State private var text: String = ""

    // Observed
    @ObservedObject var globalModel: GlobalModel
    @ObservedObject var httpClient: HTTPLandmarkClient

    var body: some View {
        NavigationView {
            VStack {
                Picker("Category", selection: $categorySelection) {
                    ForEach(Category.allCases, id: \.self) {
                        Text($0.rawValue)
                            .tag($0.rawValue)
                    }
                } //: PICKER
                .pickerStyle(SegmentedPickerStyle())
                .background(Color("blue"))
                .cornerRadius(8)
                .padding(.horizontal)
                
                NavigationListView(landmarks: landmarks, categorySelection: $categorySelection)
                
            } //: VSTACK
            .navigationBarTitle("Landmarks")
        } //: NAVIGATION
        .onAppear {
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color("gold"))], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.white)], for: .normal)
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("gold"))]
        }
    }
}

struct NavigationListView: View {
    var landmarks: [Landmark]
    @Binding var categorySelection : Category
    @State var selected: Int?
    
    var body: some View {
        List(landmarksFiltered(landmarks, categorySelection: categorySelection), id: \.id, selection: $selected) { landmark in 
            NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
                LandmarkLinkView(landmark: landmark).id(landmark.id!)
            } //: LINK
        } //: LIST
        .listStyle(InsetListStyle())
        .padding(.horizontal)
    }
    
    func landmarksFiltered(_ landmarks: [Landmark], categorySelection: Category) -> [Landmark] {
        switch categorySelection {
        case .all:
            return helpFilterLandmarks(landmarks, in: .all, selected: categorySelection)
        case .academic:
            return helpFilterLandmarks(landmarks, in: .academic, selected: categorySelection)
        case .food:
            return helpFilterLandmarks(landmarks, in: .food, selected: categorySelection)
        case .house:
            return helpFilterLandmarks(landmarks, in: .house, selected: categorySelection)
        case .social:
            return helpFilterLandmarks(landmarks, in: .social, selected: categorySelection)
        }
    }
    
    func helpFilterLandmarks(_ landmarks: [Landmark], in category: Category, selected categorySelection: Category) -> [Landmark] {
        let filteredLandmarks = landmarks.filter { (landmark) -> Bool in
            if let type = landmark.buildingType, type.lowercased() == category.rawValue.lowercased() || categorySelection == .all {
                return true
            } else {
                return false
            }
        }
        let sortedLandmarks = filteredLandmarks.sorted(by: { (firstLandmark, secondLandmark) -> Bool in
            firstLandmark.landMarkName ?? "" < secondLandmark.landMarkName ?? ""
        })
        return sortedLandmarks
    }
}

struct LandmarkLinkView: View {
    let landmark: Landmark

    var body: some View {
        HStack {
            Image(systemName: landmark.icon ?? "")
                .font(.title2)

            VStack(alignment: .leading) {
                Text(landmark.landMarkName ?? "")
                    .fontWeight(.bold)
            } //: VSTACK
        } //: HSTACK
        .padding(.vertical, 12)
        .foregroundColor(Color("blue"))
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

// struct NavigationPanelView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationPanelView(with: , globalModel: GlobalModel())
//            .environmentObject(GlobalModel())
//    }
// }
