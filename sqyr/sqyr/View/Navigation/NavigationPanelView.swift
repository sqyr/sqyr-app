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
    }

    var body: some View {
        NavigationView {
            VStack {
                // SearchBarView(text: $text, globalModel: globalModel)

                Picker("Category", selection: $categorySelection) {
                    ForEach(Category.allCases, id: \.self) {
                        Text($0.rawValue).tag($0.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                List {
                    NavigationLink(destination: LandmarkDetail(building: "Gordon and Jill Bourns College of Engineering")) {
                        Label(
                            title: { Text("Engineering Building") },
                            icon: { Image(systemName: "building.2.fill").foregroundColor(.primary) }
                        )
                    } //: LINK
                    ForEach(buildings, id: \.self) { building in
                        NavigationLink(destination: LandmarkDetail(building: building)) {
                            Label(
                                title: { Text(building) },
                                icon: { Image(systemName: "building.columns.fill").foregroundColor(.primary) }
                            )
                        } //: LINK
                    } //: LOOP
                } //: LIST
                .listStyle(InsetListStyle())
            } //: VSTACK
            .navigationBarTitle("")
            .navigationBarHidden(true)
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
