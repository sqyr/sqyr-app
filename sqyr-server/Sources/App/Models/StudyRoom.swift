//
//  File.swift
//  
//
//  Created by Tomas Perez on 3/10/21.
//

import Foundation
import Fluent
import FluentPostgresDriver
import Vapor

final class StudyRoom: Model, Content{
    static let schema = "StudyRooms"
    
    @ID(custom: "StudyRoomID")
    var id: Int?
    
    @Parent(key: "RoomID")
    var classRoomId: ClassRoom
    
    @Field(key: "Name")
    var name: String
    
    @Children(for: \.$studyRoomId)
    var usersInStudyRoom: [User]
    
    init(){}
    
    init(id: Int? = nil, classRoomId: Int, name: String) {
        self.id = id
        self.$classRoomId.id = classRoomId
        self.name = name
    }
}
