//
//  LocateClassroomView.swift
//  sqyr
//
//  Created by Steven Phun on 3/1/21.
//

import SwiftUI

struct LocateClassroomView: View {
    let building: String
    let scale: CGFloat = 1.0
    
    @State var lastScaleValue: CGFloat = 1.0
    
    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ForEach(1..<4) { index in
                    Text("Level \(index)")
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    Image(floorPlanImage(building: building, floor: index))
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
                } //: LOOP
            } //: VSTACK
        } //: SCROLL
        .navigationBarTitle("\(building) Floor Plan", displayMode: .inline)
    
    }
}

struct LocateClassroomView_Previews: PreviewProvider {
    static var previews: some View {
        LocateClassroomView(building: "TEGR")
    }
}
