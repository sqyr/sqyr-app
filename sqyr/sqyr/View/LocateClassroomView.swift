//
//  LocateClassroomView.swift
//  sqyr
//
//  Created by Steven Phun on 3/1/21.
//

import SwiftUI

struct LocateClassroomView: View {
    let building: String
    
    var body: some View {
        ScrollView {
            VStack {
                Text("\(building) Floor Plan")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                ForEach(1..<4) { index in
                    Text("\(index) Level")
                        .fontWeight(.bold)
                    
                    
                    Image(floorPlanImage(building: building, floor: index))
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
                } //: LOOP
            } //: VSTACK
        } //: SCROLL
    }
}

struct LocateClassroomView_Previews: PreviewProvider {
    static var previews: some View {
        LocateClassroomView(building: "TEGR")
    }
}
