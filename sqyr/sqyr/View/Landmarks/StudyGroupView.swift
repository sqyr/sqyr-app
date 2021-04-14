//
//  StudyGroupView.swift
//  sqyr
//
//  Created by Steven Phun on 3/2/21.
//

import SwiftUI

struct StudyGroupView: View {
    let landmark: Landmark
    let studyGroupPlaceholder: String = "Search for a Study Group"
    let studyRoomPlaceholder: String = "Search for a Room"
    
    @State var studyGroupSearchText: String = ""
    @State var studyRoomSearchText: String = ""
    @State var username: String = ""
    @State var disclosureGroupExpand: Bool = true
    
    @ObservedObject var globalModel: GlobalModel
    @ObservedObject var httpClient: HTTPLandmarkClient
    
    // MARK: Functions
    
    init(landmark: Landmark, globalModel: GlobalModel) {
        self.landmark = landmark
        self.globalModel = globalModel
        httpClient = HTTPLandmarkClient.shared

        // Fetch data
        HTTPLandmarkClient.shared.getClassRoomsByLandmark(landMark: landmark)
        HTTPLandmarkClient.shared.getStudyRoomsInClassRooms(classRoom: httpClient.classRooms!)
    }
    
    // show alert window
    func showAlertView(room: Int, group: String, create: Bool) {
        let message = create ? "Make your own study group." : group
        let alert = UIAlertController(title: "Room \(room)", message: message, preferredStyle: .alert)
        if create {
            alert.addTextField { section in
                section.placeholder = "Enter class: EGR302"
            }
        }
        alert.addTextField { username in
            username.placeholder = "Enter Your Name"
        }
        
        let buttonAction = UIAlertAction(title: create ? "Create" : "Join", style: .default) { _ in
            if alert.textFields != nil {
                if create {
                    let groupName = alert.textFields![0].text!
                    let userName = alert.textFields![1].text!
                    createStudyRoom(room: room, group: groupName, user: userName)
                } else {
                    let userName = alert.textFields![0].text!
                    joinStudyGroup(room: room, groupName: group, user: userName)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in }
        
        // add into view
        alert.addAction(buttonAction)
        alert.addAction(cancelAction)
        
        // present alert
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {})
    }

    func getStudyGroupName(roomNum: Int) -> [String] {
        var names = [String]()
        guard let roomCollection = httpClient.studyRoomsByClassRoom[roomNum] else { return names }
        for room in roomCollection {
            if let roomName = room.name {
                names.append(roomName)
            }
        }
        return names
    }
    
    func createStudyRoom(room: Int, group: String, user: String) {
        if let classRooms = httpClient.classRooms, let classRoomId = findClassRoomId(roomNumber: room) {
            let studyRoom = StudyRoom(classRoomId: classRooms[classRoomId], name: group)
            httpClient.saveStudyRoom(studyRoom: studyRoom) { roomDidSave in
                if roomDidSave {
                    httpClient.getStudyRoomsByClassRoom(classRoom: classRooms[classRoomId])
                    let user = User(firstName: user, studyRoomId: studyRoom)
                    httpClient.saveUser(user: user) { (userDidSave) in
                        if userDidSave {
                            httpClient.getUsersByStudyRoom(studyRoom: studyRoom)
                        }
                    }
                }
            }
        }
    }
    
    func findClassRoomId(roomNumber: Int) -> Int? {
        for classRoom in httpClient.classRooms! {
            if classRoom.roomNumber! == roomNumber {
                return classRoom.id
            }
        }
        return nil
    }
    
    func getUserGroupSize(room: Int, group: String) -> Int {
        guard let userGroup = httpClient.studyRoomsByClassRoom[room]?.first(where: { $0.name?.lowercased() == group.lowercased() })?.usersInStudyRoom else { return 0 }
        return userGroup.count
    }
    
    func getUserName(room: Int, group: String, user: Int) -> String {
        guard let userGroup = httpClient.studyRoomsByClassRoom[room]?.first(where: { $0.name?.lowercased() == group.lowercased() })?.usersInStudyRoom else { return "(No Name)" }
        return userGroup[user].firstName ?? "(No Name)"
    }
    
    func joinStudyGroup(room: Int, groupName: String, user: String) {
        let classRoom = httpClient.classRooms![room]
        var studyGroup = StudyRoom(classRoomId: classRoom, name: groupName)
        studyGroup.usersInStudyRoom!.append(User(firstName: groupName, studyRoomId: studyGroup))
    }
    
    func displayRoomFilter() -> [Int] {
        guard let classRooms = landmark.classRoomsId else { return [] }
        var roomNumbers = [Int]()
        guard studyRoomSearchText.count > 0 else {
            for classRoom in classRooms {
                if let roomNumber = classRoom.roomNumber {
                    roomNumbers.append(roomNumber)
                }
            }
            return roomNumbers
        }
        let classRoomsFiltered = classRooms.filter { (classRoom) -> Bool in
            if let roomNumber = classRoom.roomNumber, studyRoomSearchText.contains("\(roomNumber)") {
                return true
            } else {
                return false
            }
        }
        for classRoom in classRoomsFiltered {
            if let roomNumber = classRoom.roomNumber {
                roomNumbers.append(roomNumber)
            }
        }
        return roomNumbers
        
        // display all rooms
        
        // display only search rooms
        
        // display only search study groups
    }
    
    // MARK: - View
    
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
                ForEach(displayRoomFilter(), id: \.self) { room in
                    DisclosureGroup("Room \(room)") {
                        ForEach(getStudyGroupName(roomNum: room), id: \.self) { group in
                            DisclosureGroup("\(group)") {
                                ForEach(0 ..< getUserGroupSize(room: room, group: group), id: \.self) { user in
                                    Text(getUserName(room: room, group: group, user: user))
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                } //: LOOP - USER
                                Button(action: { showAlertView(room: room, group: group, create: false) }) {
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
                            Button(action: { showAlertView(room: room, group: "", create: true) }) {
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
