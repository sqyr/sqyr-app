//
//  TitleView.swift
//  sqyr
//
//  Created by Steven Phun on 3/2/21.
//

import SwiftUI

struct TitleView: View {
    
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .imageScale(.large)
        Text(title)
            .font(.title3)
            .fontWeight(.bold)
        } //: HSTACK
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(icon: "building.2.crop.circle.fill", title: "TEGR")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
