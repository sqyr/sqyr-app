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
                    ForEach(0..<7) { day in
                        Text(landmark.getHours[day].dayOfWeek)
                            .fontWeight(.bold)
                        Text(landmark.getHours[day].openHours)
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



struct BuildingHoursView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingHoursView(landmark: landmarks[0])
            .previewLayout(.sizeThatFits)
    }
}
