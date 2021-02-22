//
//  LandmarkCalloutView.swift
//  sqyr
//
//  Created by David Barsamian on 2/15/21.
//

import SwiftUI

struct LandmarkCalloutView: View {
    @State var title: String
    @State var distance: String
    
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    Text($title.wrappedValue)
                        .font(.title)
                        .foregroundColor(.black)
                    Text($distance.wrappedValue)
                        .font(.title3)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 25.0).foregroundColor(.white))
        }
    }
}

struct LandmarkCalloutView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkCalloutView(title: "California Baptist University", distance: "12 miles")
            .previewLayout(.sizeThatFits)
    }
}
