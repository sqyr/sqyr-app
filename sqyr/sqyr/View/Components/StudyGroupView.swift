//
//  StudyGroupView.swift
//  sqyr
//
//  Created by Steven Phun on 3/2/21.
//

import SwiftUI

struct StudyGroupView: View {
    let building: String
    let studyGroupPlaceholder: String = "Search for a Study Group"
    let studyRoomPlaceholder: String = "Search for a Study Room"
    
    @State var studyGroupSearchText: String = ""
    @State var studyRoomSearchText: String = ""
    @State var disclosureGroupExpand: Bool = true
    @State var username: String = ""
    @ObservedObject var globalModel: GlobalModel
    
    var body: some View {
        VStack {
            Group {
                // SEARCH ALL ROOMS
                StudyGroupSearchBar(title: "All \(building) Rooms", placeholder: self.studyRoomPlaceholder, text: $studyRoomSearchText)
                
                // SEARCH STUDY GROUPS
                StudyGroupSearchBar(title: "Study Groups", placeholder: self.studyGroupPlaceholder,  text: $studyGroupSearchText)
            }
            .padding(.horizontal)
            List {
                ForEach((100..<361).filter({ "\($0)".contains(self.studyRoomSearchText.lowercased()) || self.studyRoomSearchText.isEmpty }), id: \.self) { room in
                    DisclosureGroup("Room \(room)") {
                        ForEach((0..<2).filter({ "\($0)".contains(self.studyGroupSearchText.lowercased()) || self.studyGroupSearchText.isEmpty }), id: \.self) { group in
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

struct StudyGroupSearchBar: View {
    let title: String
    let placeholder: String
    @State private var isSearching: Bool = false
    @Binding var text: String
    
    var body: some View {
        VStack {
            // TITLE
            Text(self.title)
                .font(.title2)
                .bold()
                .padding(.top)
                .foregroundColor(Color("blue"))
           
            // SEARCH BAR
            HStack {
                TextField(self.placeholder, text: $text)
                    .padding(15)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 15)
                            
                            if isSearching {
                                Button(action: {
                                    self.text = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                } // : BUTTON - "X"
                            }
                        } //: HSTACK
                    ).onTapGesture {
                        self.isSearching = true
                    }
                
                    if isSearching {
                        Button(action: {
                            self.isSearching = false
                            self.text = ""
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }) {
                            Text("Cancel")
                        } //: BUTTON - CANCEL
                        .padding(.trailing, 10)
                        .transition(.move(edge: .trailing))
                        .animation(.default)
                    }
            } //: HSTACK
        } //: VSTACK
        .padding(.vertical)
    }
}

struct StudyGroupView_Previews: PreviewProvider {
    static var previews: some View {
        StudyGroupView(building: "TEGR", globalModel: GlobalModel())
    }
}
