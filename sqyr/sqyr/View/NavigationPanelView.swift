//
//  NavigationPanelView.swift
//  sqyr
//
//  Created by Steven Phun on 2/10/21.
//

import SwiftUI

struct NavigationPanelView: View {
    let buildings = getBuildings()

    var body: some View {
        VStack {
            SearchBarView(text: .constant(""))

            HStack {
                Spacer()
                HStack {
                    Circle()
                        .fill(Color.gray)
                        .opacity(0.2)
                        .frame(width: 20)
                    Text("Academic")
                }
                Spacer()
                HStack {
                    Circle()
                        .fill(Color.gray)
                        .opacity(0.2)
                        .frame(width: 20)
                    Text("Social")
                }
                Spacer()
            }
            .frame(height: 20)
            .padding()

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
        NavigationPanelView()
    }
}
