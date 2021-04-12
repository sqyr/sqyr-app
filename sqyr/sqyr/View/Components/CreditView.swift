//
//  CreditView.swift
//  sqyr
//
//  Created by Steven Phun on 3/2/21.
//

import SwiftUI

struct CreditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30) {
                    // MARK: - APP DETAIL
                    GroupBox {
                        // APP NAME
                        CreditTitleView(title: "Sqyr", icon: "info.circle")
                        Divider()
                            .padding(.vertical, 4)
                        HStack {
                            // APP IMAGE
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(12)
                                .shadow(radius: 8)
                                .frame(width: 80, height: 80)
                            
                            // APP DESCRIPTION
                            Text("Sqyr using augmented-reality technology to display real-time 3-D directions and landmarks around California Baptist University. The app is designed to help students navigate campus and connect with others by creating or joining study groups in designated areas.")
                                .font(.caption)
                        } //: HSTACK
                    } //: BOX
                    
                    // MARK: - PROJECT CONTRIBUTORS
                    GroupBox {
                        CreditTitleView(title: "Contributors", icon: "person.2")
                        
                        CreditItemView(title: "Project Manager", name: "Dr. Im")
                        CreditItemView(title: "AR Developer", name: "David Barsamian, True Sarmiento")
                        CreditItemView(title: "Backend Developer", name: "Tomas Perez")
                        CreditItemView(title: "UI Developer", name: "Lauren Nelson, Steven Phun")
                        CreditItemView(title: "Digital Designer", name: "Clay Bakhoum")
                        CreditItemView(title: "Photographer", name: "Lauren Nelson")
                    } //: BOX
                    
                    // MARK: - APPLICATION INFO
                    GroupBox {
                        CreditTitleView(title: "Application", icon: "iphone")
                        
                        CreditItemView(title: "Github Repo", name: "Sqyr App")
                        CreditItemView(title: "Compatibility", name: "iOS 14")
                        CreditItemView(title: "SwiftUI", name: "2.0")
                        CreditItemView(title: "Version", name: "0.1.0")
                    } //: BOX
                } //: VSTACK
                .navigationBarTitle(Text("Credits"), displayMode: .large)
                .navigationBarItems(
                    trailing:
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        })  {
                            Text("Done")
                        }//: BUTTON
                ) //: ITEMS
                .padding()
            } //: SCROLL
        } //: NAVIGATION
    }
}

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

struct CreditView_Previews: PreviewProvider {
    static var previews: some View {
        CreditView()
    }
}
