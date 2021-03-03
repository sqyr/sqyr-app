//
//  CreditTitleView.swift
//  sqyr
//
//  Created by Steven Phun on 3/2/21.
//

import SwiftUI

struct CreditTitleView: View {
    
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            Text(title.uppercased())
                .fontWeight(.bold)
            Spacer()
            Image(systemName: icon)
        } //: HSTACK
    }
}

struct CreditTitleView_Previews: PreviewProvider {
    static var previews: some View {
        CreditTitleView(title: "Sqyr", icon: "info.circle")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
