//
//  BuildingHoursView.swift
//  sqyr
//
//  Created by Steven Phun on 3/1/21.
//

import SwiftUI

struct BuildingHoursView: View {
    let landmark: LandmarkJson
    
    var body: some View {
        GroupBox {
            HStack {
                Image(systemName: "clock")
                Text("Hours of Operation")
                    .fontWeight(.bold)
            } //: HSTACK
            VStack {
                LazyVGrid(columns: getGridLayout(), spacing: 6) {
                    ForEach(0..<getWeekday().count, id:\.self) { day in
                        Text(getWeekday()[day])
                            .fontWeight(.bold)
                        Text(getTime()[day])
                    }
                } //: GRID
            } //: VSTACK
        } //: BOX
        .foregroundColor(.secondary)
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
        BuildingHoursView(landmark: landmarks[0])
            .previewLayout(.sizeThatFits)
    }
}
