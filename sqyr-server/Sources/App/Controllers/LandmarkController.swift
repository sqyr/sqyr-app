//
//  File.swift
//
//
//  Created by Tomas Perez on 4/10/21.
//
import Fluent
import Foundation
import Vapor

final class LandmarkController {
    func create(_ req: Request) throws -> EventLoopFuture<Landmark> {
        let landmark = try req.content.decode(Landmark.self)
        return landmark.create(on: req.db).map { landmark }
    }

    func all(_ req: Request) throws -> EventLoopFuture<[Landmark]> {
        Landmark.query(on: req.db)
            .with(\.$classRoomsId) { classRoomsId in
                classRoomsId.with(\.$studyRoomsId) { studyRoomsId in
                    studyRoomsId.with(\.$usersInStudyRoom)
                }
            }
            .all()
    }

    func byID(_ req: Request) throws -> EventLoopFuture<[Landmark]> {
        guard let landmarkId = req.parameters.get("LandMarkID", as: Int.self) else {
            throw Abort(.notFound)
        }
        return Landmark.query(on: req.db).filter(\.$id, .equal, landmarkId)
            .with(\.$classRoomsId)
            .all()
    }
}
