//
//  JoinStudyRoomView.swift
//  sqyr
//
//  Created by Steven Phun on 3/8/21.
//

import SwiftUI

struct JoinStudyRoomView: View {
    
    @State var username: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {}) {
                    Text("Cancel")
                }
            } //: HSTACK
            .padding()
            
            TextField("Enter Your Name", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
        } //: VSTACK
    }
}

struct JoinStudyRoomView_Previews: PreviewProvider {
    static var previews: some View {
        JoinStudyRoomView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
