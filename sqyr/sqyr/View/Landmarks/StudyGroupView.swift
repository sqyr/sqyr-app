//
//  StudyGroupView.swift
//  sqyr
//
//  Created by Steven Phun on 3/2/21.
//

import SwiftUI

// MARK: - StudyGroupView

struct StudyGroupView: View {
    var landmark: Landmark
    
    let studyGroupPlaceholder: String = "Search for a Study Group"
    let studyRoomPlaceholder: String = "Search for a Room"
    @State var studyGroupSearchText: String = ""
    @State var studyRoomSearchText: String = ""

    @ObservedObject var globalModel: GlobalModel
    @ObservedObject var httpClient = HTTPLandmarkClient()

    // show alert window
    static func showAlertView(classRoom: ClassRoom, studyRoom: StudyRoom? = nil, group: String, create: Bool, httpClient: HTTPLandmarkClient) {
        let message = create ? "Make your own study group." : group
        let alert = UIAlertController(title: "Room \(classRoom.roomNumber ?? 0)", message: message, preferredStyle: .alert)
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
                    createStudyRoom(in: classRoom, called: groupName, with: userName, httpClient: httpClient)
                } else {
                    let userName = alert.textFields![0].text!
                    if let studyRoom = studyRoom {
                        joinStudyRoom(studyRoom, with: userName, httpClient: httpClient)
                    }
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

    static func createStudyRoom(in classRoom: ClassRoom, called groupName: String, with userName: String, httpClient: HTTPLandmarkClient) {
        let studyRoom = StudyRoom(classRoomId: classRoom, name: groupName)
        httpClient.saveStudyRoom(studyRoom: studyRoom) { savedRoom in
            let newUser = User(firstName: userName, studyRoomId: savedRoom)
            httpClient.saveUser(user: newUser, completion: nil)
        }
        httpClient.getStudyRoomsByClassRoom(classRoom: classRoom)
    }

    static func joinStudyRoom(_ studyRoom: StudyRoom, with userName: String, httpClient: HTTPLandmarkClient) {
        let newUser = User(firstName: userName, studyRoomId: studyRoom)
        httpClient.saveUser(user: newUser, completion: nil)
        httpClient.getUsersByStudyRoom(studyRoom: studyRoom)
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
                ForEach(landmark.classRoomsId ?? [], id: \.self) { room in
                    ClassRoomDisclosure(classRoom: room, httpClient: httpClient)
                } //: LOOP - ROOMS
            } //: LIST
            .listStyle(InsetGroupedListStyle())
        } //: VSTACK
        .edgesIgnoringSafeArea(.bottom)
    }
}

// MARK: - ClassRoomDisclosure

struct ClassRoomDisclosure: View {
    let classRoom: ClassRoom
    @State var studyRooms = [StudyRoom]()
    
    @ObservedObject var httpClient: HTTPLandmarkClient

    var body: some View {
        DisclosureGroup("Room \(classRoom.roomNumber ?? -1)") {
            ForEach(studyRooms, id: \.self) { studyRoom in
                StudyRoomDisclosure(classRoom: classRoom, studyRoom: studyRoom, httpClient: httpClient)
            } //: LOOP - STUDY GROUP
            DisclosureGroup("Create Your Own Group", isExpanded: .constant(true)) {
                Button(action: { StudyGroupView.showAlertView(classRoom: classRoom, group: "", create: true, httpClient: httpClient) }) {
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
        .onAppear {
            httpClient.getStudyRoomsByClassRoom(classRoom: classRoom)
        }
        .onReceive(httpClient.$studyRooms) { (output) in
            if let studyRooms = output, studyRooms.first?.classRoomId == classRoom {
                self.studyRooms.removeAll()
                self.studyRooms.append(contentsOf: studyRooms)
            }
        }
    }
}

// MARK: - StudyGroupDisclosure

struct StudyRoomDisclosure: View {
    let classRoom: ClassRoom
    let studyRoom: StudyRoom
    @State var users = [User]()
    
    @ObservedObject var httpClient: HTTPLandmarkClient

    var body: some View {
        DisclosureGroup(studyRoom.name ?? "") {
            ForEach(users, id: \.self) { user in
                Text("\(user.firstName ?? "")")
                    .foregroundColor(.secondary)
                    .font(.footnote)
            } //: LOOP - USER
            Button(action: { StudyGroupView.showAlertView(classRoom: classRoom, studyRoom: studyRoom, group: studyRoom.name ?? "", create: false, httpClient: httpClient) }) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("gold"))
                    .padding(.horizontal)
                    .overlay(Text("Join").foregroundColor(.white))
            } //: BUTTON
        } //: DISCLOSURE
        .font(.headline)
        .foregroundColor(Color("blue"))
        .onAppear {
            httpClient.getUsersByStudyRoom(studyRoom: studyRoom)
        }
        .onReceive(httpClient.$users) { (output) in
            if let users = output, users.first?.studyRoomId == studyRoom {
                self.users.removeAll()
                self.users.append(contentsOf: users)
            }
        }
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
