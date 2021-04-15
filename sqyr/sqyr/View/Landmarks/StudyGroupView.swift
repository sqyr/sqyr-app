//
//  StudyGroupView.swift
//  sqyr
//
//  Created by Steven Phun on 3/2/21.
//

import SwiftUI

// MARK: - StudyGroupView

struct StudyGroupView: View {
    let landmark: Landmark
    let studyGroupVC: StudyGroupViewController
    let studyGroupPlaceholder: String = "Search for a Study Group"
    let studyRoomPlaceholder: String = "Search for a Room"
    
    @State var studyGroupSearchText: String = ""
    @State var studyRoomSearchText: String = ""
    @State var username: String = ""
    @State var disclosureGroupExpand: Bool = true
    @State var classRoomNumbers = [Int]() // Class Room Numbers, NOT IDs
    @State var studyRoomNames = [Int: [String]]() // Class Room Number: [Study Room Names]
    @State var usersInStudyRooms = [String: [String]]() // Study Room Name: [User Names]
    
    @ObservedObject var globalModel: GlobalModel
    
    init(landmark: Landmark, globalModel: GlobalModel) {
        self.landmark = landmark
        self.globalModel = globalModel
        self.studyGroupVC = StudyGroupViewController(landmark: landmark)
    }
    
    var body: some View {
        VStack {
            Group {
                // SEARCH ALL ROOMS
                StudyGroupTitle(icon: landmark.icon ?? "", title: landmark.landMarkName ?? "")
                StudyGroupSearchBar(placeholder: self.studyRoomPlaceholder, text: $studyRoomSearchText)
                
                // SEARCH STUDY GROUPS
                StudyGroupTitle(icon: "person.3.fill", title: "Study Groups")
                StudyGroupSearchBar(placeholder: self.studyGroupPlaceholder, text: $studyGroupSearchText)
            }
            .padding(.horizontal)
            
            // LIST OF ROOMS
            List {
                ForEach(classRoomNumbers, id: \.self) { room in
                    ClassRoomDisclosure(studyGroupVC: studyGroupVC, room: room, studyRoomNames: studyRoomNames)
                } //: LOOP - ROOMS
            } //: LIST
            .listStyle(InsetGroupedListStyle())
        } //: VSTACK
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            self.classRoomNumbers = studyGroupVC.displayRoomFilter(searchText: studyRoomSearchText)
            for roomNumber in self.classRoomNumbers {
                self.studyRoomNames[roomNumber] = studyGroupVC.getStudyGroupName(roomNum: roomNumber)
                // TOOD
                
            }
        }
    }
}

// MARK: - ClassRoomDisclosure

struct ClassRoomDisclosure: View {
    let studyGroupVC: StudyGroupViewController
    var room: Int
    var studyRoomNames: [Int: [String]]
    
    var body: some View {
        DisclosureGroup("Room \(room)") {
            ForEach(studyRoomNames[room]!, id: \.self) { group in
                StudyGroupDisclosure(studyGroupVC: studyGroupVC, room: room, group: group)
            } //: LOOP - STUDY GROUP
            DisclosureGroup("Create Your Own Group", isExpanded: .constant(true)) {
                Button(action: { studyGroupVC.showAlertView(room: room, group: "", create: true) }) {
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
    }
}

// MARK: - StudyGroupDisclosure

struct StudyGroupDisclosure: View {
    let studyGroupVC: StudyGroupViewController
    var room: Int
    var group: String
    
    var body: some View {
        DisclosureGroup("\(group)") {
            ForEach(0 ..< studyGroupVC.getUserGroupSize(room: room, group: group), id: \.self) { user in
                Text(studyGroupVC.getUserName(room: room, group: group, user: user))
                    .foregroundColor(.secondary)
                    .font(.footnote)
            } //: LOOP - USER
            Button(action: { studyGroupVC.showAlertView(room: room, group: group, create: false) }) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("gold"))
                    .padding(.horizontal)
                    .overlay(Text("Join").foregroundColor(.white))
            } //: BUTTON
        } //: DISCLOSURE
        .font(.headline)
        .foregroundColor(Color("blue"))
    }
}

// MARK: - StudyGroupTitle

struct StudyGroupTitle: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(self.title)
                .bold()
        } //: HSTACK
        .font(.title2)
        .padding(.top)
        .foregroundColor(Color("blue"))
    }
}

// MARK: - StudyGroupSearchBar

struct StudyGroupSearchBar: View {
    let placeholder: String
    @State private var isSearching: Bool = false
    @Binding var text: String

    var body: some View {
        VStack {
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

// TODO: Fix preview
// struct StudyGroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudyGroupView(landmark: landmarks[0], globalModel: GlobalModel())
//    }
// }
