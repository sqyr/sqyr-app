//
//  File.swift
//  
//
//  Created by Tomas Perez on 3/10/21.
//

import Foundation
import Vapor
import Fluent
import FluentPostgresDriver

final class ClassRoom: Model, Content{
    static let schema = "ClassRoom"
    
    @ID(custom: "RoomID")
    var id: Int?
    
    @Parent(key: "ClassRoomsID")
    var landmark: Landmark
    
    @Field(key: "RoomNumber")
    var roomNumber: Int
    
    @Children(for: \.$classRoomId)
    var studyRoomsId: [StudyRoom]
    
    init(){}
    
    init(id: Int? = nil, landmark: Int, roomNumber: Int){
        self.id = id
        self.$landmark.id = landmark // This might not be correct...
        self.roomNumber = roomNumber
    }
}
