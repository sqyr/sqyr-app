//
//  NavigationPanelView.swift
//  sqyr
//
//  Created by Steven Phun on 2/10/21.
//

import SwiftUI

struct NavigationPanelView: View {
    let buildings = getBuildings()

    @State private var categorySelection: Category = .all
    @State private var text: String = ""

    @ObservedObject var globalModel: GlobalModel

    init(globalModel: GlobalModel) {
        self.globalModel = globalModel
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color("gold"))], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.white)], for: .normal)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("gold"))]
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
                .background(Color("blue"))
                .pickerStyle(SegmentedPickerStyle())
                .foregroundColor(.red)
                .cornerRadius(8)
                .padding()

                List {
                    ForEach(buildings, id: \.self) { building in
                        NavigationLink(destination: LandmarkDetail(building: building)) {
                            HStack {
                                Image(systemName: "building.2.crop.circle.fill")
                                    .font(.title2)
                                Text("Engineering Building")
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

func getBuildings() -> [String] {
    var arrayOfBuildings = [String]()

    for i in 1 ... 10 {
        arrayOfBuildings.append("Building #\(i)")
    }

    return arrayOfBuildings
}

struct NavigationPanelView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPanelView(globalModel: GlobalModel())
    }
}

enum Category: String, CaseIterable {
    case all = "All"
    case academic = "Academic"
    case social = "Social"

    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
