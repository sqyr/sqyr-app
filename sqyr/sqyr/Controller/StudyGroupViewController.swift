//
//  StudyGroupViewController.swift
//  sqyr
//
//  Created by David Barsamian on 4/14/21.
//

import Foundation
import SwiftUI
import UIKit

struct StudyGroupViewController {
    let landmark: Landmark
    
    @ObservedObject var httpClient: HTTPLandmarkClient
    
    init(landmark: Landmark) {
        self.landmark = landmark
        httpClient = HTTPLandmarkClient.shared
        httpClient.getClassRoomsByLandmark(landMark: landmark)
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
        httpClient.getClassRoomsByLandmark(landMark: landmark)
        let filteredClassrooms = httpClient.classRooms?.filter { (room) -> Bool in
            if room.roomNumber! == roomNum {
                return true
            } else {
                return false
            }
        }
        guard let classrooms = filteredClassrooms,
              let room = classrooms.first,
              let studyRooms = room.studyRoomsId
        else {
            print("No study groups found for \(roomNum)")
            return names
        }
        for studyRoom in studyRooms {
            if studyRoom.usersInStudyRoom != nil {
                print("\(studyRoom.name): \(studyRoom.usersInStudyRoom)")
            }
            names.append(studyRoom.name!)
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
                    httpClient.saveUser(user: user) { userDidSave in
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
        return 1
    }
    
    func getUserName(room: Int, group: String, user: Int) -> String {
        return ""
    }
    
    func joinStudyGroup(room: Int, groupName: String, user: String) {
        let classRoom = httpClient.classRooms![room]
        var studyGroup = StudyRoom(classRoomId: classRoom, name: groupName)
        studyGroup.usersInStudyRoom!.append(User(firstName: groupName, studyRoomId: studyGroup))
    }
    
    func displayRoomFilter(searchText studyRoomSearchText: String) -> [Int] {
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
}
