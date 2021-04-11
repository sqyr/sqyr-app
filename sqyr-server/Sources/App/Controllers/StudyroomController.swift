//
//  File.swift
//
//
//  Created by Tomas Perez on 4/10/21.
//
import Foundation
import Vapor
import Fluent

final class StudyroomController {

    func create(_ req: Request) throws -> EventLoopFuture<StudyRoom> {
        let studyroom = try req.content.decode(StudyRoom.self)
        return studyroom.create(on: req.db).map { studyroom }
    }

    func all(_ req: Request) throws -> EventLoopFuture<[StudyRoom]>{
        StudyRoom.query(on: req.db).all()
    }

    func byID(_ req: Request) throws -> EventLoopFuture<[StudyRoom]>{
        guard let studyroomId = req.parameters.get("StudyRoomID", as: Int.self) else{
            throw Abort(.notFound)
        }
        return StudyRoom.query(on: req.db).filter(\.$id, .equal, studyroomId)
            .all()
    }

    func getByClassRoomId(_ req: Request) throws -> EventLoopFuture<[StudyRoom]>{
        guard let classRoomId = req.parameters.get("RoomID", as: Int.self) else{
            throw Abort(.notFound)
        }

        return StudyRoom.query(on: req.db).filter(\.$classRoomId.$id, .equal, classRoomId)
            .with(\.$classRoomId)
            .all()
    }

    func delete(_ req: Request) throws -> EventLoopFuture<HTTPStatus>{
        StudyRoom.find(req.parameters.get("StudyRoomID"), on: req.db).unwrap(or: Abort(.notFound))
            .flatMap{
                $0.delete(on: req.db)
            }.transform(to: .ok)
    }
}
