//
//  BuildingHoursView.swift
//  sqyr
//
//  Created by Steven Phun on 3/1/21.
//

import SwiftUI

struct BuildingHoursView: View {
    var body: some View {
        GroupBox {
            VStack {
                LazyVGrid(columns: getGridLayout(), spacing: 10, content: {
                    ForEach(0..<getWeekday().count, id:\.self) { day in
                        Text(getWeekday()[day])
                            .fontWeight(.bold)
                        Text(getTime()[day])
                    }
                })
            }
        }
    }
}

func getGridLayout() -> [GridItem] {
    return Array(repeating: GridItem(.flexible(), spacing: 2), count: 2)
}

func getWeekday() -> [String] {
    return ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
}

func getTime() -> [String] {
    return ["8:00AM - 5:00PM", "8:00AM - 5:00PM", "8:00AM - 5:00PM", "8:00AM - 5:00PM", "8:00AM - 5:00PM", "Closed", "Closed"]
}

struct BuildingHoursView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingHoursView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
