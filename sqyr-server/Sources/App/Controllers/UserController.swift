//
//  File.swift
//
//
//  Created by Tomas Perez on 4/10/21.
//
import Fluent
import Foundation
import Vapor

final class UserController {
    func create(_ req: Request) throws -> EventLoopFuture<User> {
        let user = try req.content.decode(User.self)
        return user.create(on: req.db).map { user }
    }

    func all(_ req: Request) throws -> EventLoopFuture<[User]> {
        User.query(on: req.db).all()
    }

    func byID(_ req: Request) throws -> EventLoopFuture<[User]> {
        guard let userId = req.parameters.get("UserID", as: Int.self) else {
            throw Abort(.notFound)
        }
        return User.query(on: req.db).filter(\.$id, .equal, userId)
            .all()
    }

    func getByStudyroomId(_ req: Request) throws -> EventLoopFuture<[User]> {
        guard let studyRoomId = req.parameters.get("StudyRoomID", as: Int.self) else {
            throw Abort(.notFound)
        }

        return User.query(on: req.db).filter(\.$studyRoomId.$id, .equal, studyRoomId)
            .with(\.$studyRoomId) { studyRoomId in
                studyRoomId.with(\.$usersInStudyRoom)
            }
            .all()
    }

    func delete(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        User.find(req.parameters.get("UserID"), on: req.db).unwrap(or: Abort(.notFound))
            .flatMap {
                $0.delete(on: req.db)
            }.transform(to: .ok)
    }
}
