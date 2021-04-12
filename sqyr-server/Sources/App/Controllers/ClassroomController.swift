//
//  File.swift
//
//
//  Created by Tomas Perez on 4/10/21.
//
import Fluent
import Foundation
import Vapor

final class ClassroomController {
    func create(_ req: Request) throws -> EventLoopFuture<ClassRoom> {
        let classroom = try req.content.decode(ClassRoom.self)
        return classroom.create(on: req.db).map { classroom }
    }

    func all(_ req: Request) throws -> EventLoopFuture<[ClassRoom]> {
        ClassRoom.query(on: req.db).all()
    }

    func byID(_ req: Request) throws -> EventLoopFuture<[ClassRoom]> {
        guard let classroomId = req.parameters.get("RoomID", as: Int.self) else {
            throw Abort(.notFound)
        }
        return ClassRoom.query(on: req.db).filter(\.$id, .equal, classroomId)
            .all()
    }

    func getByLandmarkId(_ req: Request) throws -> EventLoopFuture<[ClassRoom]> {
        guard let landmarkId = req.parameters.get("LandMarkID", as: Int.self) else {
            throw Abort(.notFound)
        }

        return ClassRoom.query(on: req.db).filter(\.$landmark.$id, .equal, landmarkId)
            .with(\.$landmark)
            .all()
    }
}
