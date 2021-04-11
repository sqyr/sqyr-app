//
//  File.swift
//
//
//  Created by Tomas Perez on 3/10/21.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateStudyRoom: Migration{
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("StudyRooms")
            .field("StudyRoomID", .int, .required, .identifier(auto: true))
            .field("RoomID", .int, .required, .references("ClassRoom", "RoomID"))
            .field("Name", .string, .required)
            .unique(on: "StudyRoomID")
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("StudyRooms").delete()
    }
}
