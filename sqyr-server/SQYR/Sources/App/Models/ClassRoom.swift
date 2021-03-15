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
    var classRoomsId: Landmark
    
    @Field(key: "RoomNumber")
    var roomNumber: Int
    
    init(){}
    
    init(id: Int? = nil, classRoomsId: Int, roomNumber: Int){
        self.id = id
        self.$classRoomsId.id = classRoomsId // This might not be correct...
        self.roomNumber = roomNumber
    }
}
