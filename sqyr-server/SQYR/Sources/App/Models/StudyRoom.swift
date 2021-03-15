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
    var classRoomsId: ClassRoom
    
    @Field(key: "Name")
    var name: String
    
    init(){}
    
    init(id: Int? = nil, classRoomsId: Int, name: String) {
        self.id = id
        self.$classRoomsId.id = classRoomsId
        self.name = name
    }
}
