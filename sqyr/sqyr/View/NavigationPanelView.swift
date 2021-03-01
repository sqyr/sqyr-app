//
//  NavigationPanelView.swift
//  sqyr
//
//  Created by Steven Phun on 2/10/21.
//

import SwiftUI

struct NavigationPanelView: View {
    let buildings = getBuildings()

    @State var categorySelection: Category = .all
    @State var text: String = ""

    @ObservedObject var globalModel: GlobalModel

    var body: some View {
        VStack {
            SearchBarView(text: $text, globalModel: globalModel)

            Picker("Category", selection: $categorySelection) {
                ForEach(Category.allCases, id: \.self) {
                    Text($0.rawValue).tag($0.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            NavigationView {
                VStack {
                    List(buildings, id: \.self) { building in
                        NavigationLink(destination: BuildingPopUpView(building: building)) {
                            HStack {
                                Rectangle()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.black)
                                Text(building)
                            }
                        }
                    }
                    .navigationBarTitle("Landmarks")
                }
            }
            
        }
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
