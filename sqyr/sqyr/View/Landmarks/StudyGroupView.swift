//
//  StudyGroupView.swift
//  sqyr
//
//  Created by Steven Phun on 3/2/21.
//

import SwiftUI

struct StudyGroupView: View {
    let landmark: LandmarkJson
    let studyGroupPlaceholder: String = "Search for a Study Group"
    let studyRoomPlaceholder: String = "Search for a Room"
    
    @State var studyGroupSearchText: String = ""
    @State var studyRoomSearchText: String = ""
    @State var username: String = ""
    @State var disclosureGroupExpand: Bool = true
    
    @ObservedObject var globalModel: GlobalModel
    
    // MARK: FUNCTIONS
    
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
        
        let buttonAction = UIAlertAction(title: create ? "Create" : "Join", style: .default) { (_) in
            if alert.textFields != nil {
                if create {
                    let groupName = alert.textFields![0].text!
                    let userName = alert.textFields![1].text!
                    updateStudyGroup(key: room, group: groupName, user: userName)
                } else {
                    let userName = alert.textFields![0].text!
                    joinStudyGroup(room: room, groupName: group, user: userName)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (_) in }
        
        // add into view
        alert.addAction(buttonAction)
        alert.addAction(cancelAction)
        
        // present alert
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {})
    }
    
    // TODO start - replace codes server side code
    @State var studyGroups: Dictionary<Int,[Dictionary<String,[String]>]> = Dictionary<Int,[Dictionary<String,[String]>]>()
    
    var initlizeStudyGroup: Dictionary<Int,[Dictionary<String,[String]>]> {
        var dict: Dictionary<Int,[Dictionary<String,[String]>]> = Dictionary<Int,[Dictionary<String,[String]>]>()
        for room in landmark.getLandmarkRoomNumbers {
            dict[room] = [Dictionary<String,[String]>]()
        }
        
        studyGroups = dict
        return dict
    }
    
    func getStudyGroupSize(roomNum: Int) -> Int {
        if studyGroups[roomNum] != nil {
            return studyGroups[roomNum]!.count
        }
        
        return 0
    }

    func getStudyGroupName(roomNum: Int) -> [String] {
        if studyGroups[roomNum] != nil {
            var array: [String] = []
            
            for dict in studyGroups[roomNum]! {
                for (key, _) in dict {
                    array.append(key)
                }
            }
            
            return array
        }
        
        return []
    }
    
    func updateStudyGroup(key: Int, group: String, user: String) {
        var dict: [Int: [[String: [String]]]] = studyGroups
        let value: [String: [String]] = [group: [user]]
        
        if dict[key] == nil {
            dict[key] = []
        }
        
        dict[key]!.append(value)
        studyGroups = dict
    }
    
    func getUserGroupSize(room: Int, group: String) -> Int {
        let array: [[String: [String]]] = studyGroups[room]!
        
        for dict in array {
            for (key, _) in dict {
                if key == group {
                    return dict[key]!.count
                }
            }
        }
        
        return 0
    }
    
    func getUserName(room: Int, group: String, user: Int) -> String {
        let array: [[String: [String]]] = studyGroups[room]!
        
        for dict in array {
            for (key, _) in dict {
                if key == group {
                    return dict[key]![user]
                }
            }
        }
        
        return ""
    }
    
    func joinStudyGroup(room: Int, groupName: String, user: String) -> Void {
        var temp = studyGroups
        var count = -1
    
        for group in temp[room]! {
            count = count + 1
            for (key, _) in group {
                if key == groupName {
                    (((temp[room]!)[count])[key]!).append(user)
                }
            }
        }
        
        studyGroups = temp
    }
    
    func displayRoomFilter() -> [Int] {
        let roomsAll: [Int] = landmark.getLandmarkRoomNumbers
        var roomsFiltered: [Int] = []
        
        // display all rooms
        if self.studyGroupSearchText.isEmpty && self.studyRoomSearchText.isEmpty {
            return roomsAll
        }
        
        // display only search rooms
        if self.studyGroupSearchText.isEmpty {
            for room in roomsAll {
                if "\(room)".starts(with: self.studyRoomSearchText.lowercased()) {
                    roomsFiltered.append(room)
                }
            }
        }
        
        // display only search study groups
        if self.studyRoomSearchText.isEmpty {
            var set: Set<Int> = []
            for room in roomsAll {
                for group in getStudyGroupName(roomNum:room) {
                    if group.contains(self.studyGroupSearchText.lowercased()) {
                        set.insert(room)
                    }
                }
            }
            
            for room in set {
                roomsFiltered.append(room)
            }
        }

        
        return roomsFiltered
    }
    
    // TODO end - replace codes server side code
    
    var body: some View {
        VStack {
            Group {
                // SEARCH ALL ROOMS
                StudyGroupTitle(icon: landmark.icon, title: landmark.name)
                StudyGroupSearchBar(placeholder: self.studyRoomPlaceholder, text: $studyRoomSearchText)
                
                // SEARCH STUDY GROUPS
                StudyGroupTitle(icon: "person.3.fill",title: "Study Groups")
                StudyGroupSearchBar(placeholder: self.studyGroupPlaceholder,  text: $studyGroupSearchText)
            }
            .padding(.horizontal)
            
            // LIST OF ROOMS
            List {
                ForEach(displayRoomFilter(), id: \.self) { room in
                    DisclosureGroup("Room \(room)") {
                        ForEach((getStudyGroupName(roomNum:room)), id: \.self) { group in
                            DisclosureGroup("\(group)") {
                                ForEach(0..<getUserGroupSize(room: room, group: group), id: \.self) { user in
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

struct StudyGroupView_Previews: PreviewProvider {
    static var previews: some View {
        StudyGroupView(landmark: landmarks[0], globalModel: GlobalModel())
    }
}
