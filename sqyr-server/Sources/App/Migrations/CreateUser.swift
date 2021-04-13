//
//  File.swift
//
//
//  Created by Tomas Perez on 3/10/21.
//

import Fluent
import FluentPostgresDriver
import Foundation

struct CreateUser: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("Users")
            .field("UserID", .int, .required, .identifier(auto: true))
            .field("FirstName", .string, .required)
            .field("StudyRoomID", .int, .required, .references("StudyRooms", "StudyRoomID"))
            .field("Creation", .string)
            .unique(on: "UserID")
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("Users").delete()
    }
}
