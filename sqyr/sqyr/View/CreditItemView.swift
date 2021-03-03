//
//  CreditItemView.swift
//  sqyr
//
//  Created by Steven Phun on 3/2/21.
//

import SwiftUI

struct CreditItemView: View {
    
    let title: String
    let name: String
    
    var body: some View {
        VStack {
            // DIVIDER
            Divider()
                .padding(.vertical, 4)
            
            // CONTENT
            HStack {
                // TITLE
                Text(title)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                // NAME
                Text(name)
            } //: HSTACK
        } //: VSTACK
    }
}

struct CreditItemView_Previews: PreviewProvider {
    static var previews: some View {
        CreditItemView(title: "Developer", name: "Sqyr")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
