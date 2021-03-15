//
//  StudyGroupView.swift
//  sqyr
//
//  Created by Steven Phun on 3/2/21.
//

import SwiftUI

struct StudyGroupView: View {
    let building: String
    
    @State var text: String = ""
    @State var disclosureGroupExpand: Bool = true
    @State var username: String = ""
    @ObservedObject var globalModel: GlobalModel
    
    var body: some View {
        VStack {
            Group {
                // SEARCH STUDY GROUPS
                Text("Study Groups")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                    .foregroundColor(Color("blue"))
                SearchBarView(text: $text, model: globalModel)
                
                // DISPLAY ALL ROOMS
                Text("All \(building) Rooms").font(.title2).bold().foregroundColor(Color("blue"))
                SearchBarView(text: $text, model: globalModel)
            }
            .padding(.horizontal)
            List {
                ForEach(100..<361) { room in
                    DisclosureGroup("Room \(room)") {
                        ForEach(0..<2) { group in
                            DisclosureGroup("Study Group \(group)") {
                                ForEach(0..<3) { user in
                                    Text("Student \(user)")
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                } //: LOOP - USER
                                Button(action: { showAlertView(title: "Room \(room)", message: "Group \(group)", create: false) }) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color("gold"))
                                        .padding(.horizontal)
                                        .overlay(Text("Join").foregroundColor(.white))
                                } //: BUTTON
                            } //: DISCLOSURE
                            .font(.headline)
                            .foregroundColor(Color("blue"))
                        } //: LOOP - STUDY GROUP
                        DisclosureGroup("Create Your Own Group", isExpanded: .constant(true)) {
                        Button(action: { showAlertView(title: "Room \(room)", message: "Make your own study group." , create: true) }) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color("blue"))
                                .padding(.horizontal)
                                .overlay(Text("Create").foregroundColor(.white))
                        } //: BUTTON
                        } //: DISCLOSURE - CREATE STUDY GROUP
                        .font(.headline)
                        .foregroundColor(Color("blue"))
                    } //: DISCLOSURE - ROOMS
                    .foregroundColor(.secondary)
                } //: LOOP - ROOMS
            } //: LIST
            .listStyle(InsetGroupedListStyle())
        } //: VSTACK
        .edgesIgnoringSafeArea(.bottom)
    }
    
    func showAlertView(title: String, message: String, create: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if create {
            alert.addTextField { section in
                section.placeholder = "Enter class: EGR302"
            }
        }
        alert.addTextField { username in
            username.placeholder = "Enter Your Name"
        }
        
        let buttonAction = UIAlertAction(title: create ? "Create" : "Join", style: .default) { (_) in
            if alert.textFields != nil {
                username = alert.textFields![0].text!
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (_) in }
        
        alert.addAction(buttonAction)
        alert.addAction(cancelAction)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {})
    }
}



struct roomRowView: View {
    let text: String
    let iconImage: String
    let iconColor: Color
    
    var body: some View {
        Text(text)
            .font(.caption)
        Spacer()
        Image(systemName: iconImage)
            .foregroundColor(iconColor)
    }
}

struct StudyGroupView_Previews: PreviewProvider {
    static var previews: some View {
        StudyGroupView(building: "TEGR", globalModel: GlobalModel())
    }
}
