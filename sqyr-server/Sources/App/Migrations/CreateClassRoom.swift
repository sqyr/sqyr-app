//
//  File.swift
//
//
//  Created by Tomas Perez on 3/10/21.
//

import Fluent
import FluentPostgresDriver
import Foundation

struct CreateClassroom: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("ClassRoom")
            .field("RoomID", .int, .required, .identifier(auto: true))
            .field("ClassRoomsID", .int, .required, .references("LandMarks", "LandMarkID"))
            .field("RoomNumber", .int, .required)
            .unique(on: "RoomID")
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("ClassRoom").delete()
    }
}
