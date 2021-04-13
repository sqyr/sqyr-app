//
//  File.swift
//
//
//  Created by Tomas Perez on 3/10/21.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateLandmark: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("LandMarks")
            .field("LandMarkID", .int, .required, .identifier(auto: true))
            .field("LandMarkName", .string, .required)
            .field("Description", .string, .required)
            .field("Hours", .string)
            .field("CoordinatesLat", .double, .required)
            .field("CoordinatesLon", .double, .required)
            .field("BuildingType", .string, .required)
            .field("Icon", .string, .required)
            .field("Images", .string)
            .field("ShowInfoLeft", .bool)
            .field("FloorPlanImage", .string)
            .unique(on: "LandMarkID")
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("LandMarks").delete()
    }
}
