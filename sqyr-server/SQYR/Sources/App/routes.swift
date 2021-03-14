
// Below are all different types of requests that can be made to our database.

import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    // Adding landmarks to DB
    app.post("Landmarks"){req -> EventLoopFuture<Landmark> in
        let landmark = try req.content.decode(Landmark.self) // content = body of http request
        return landmark.create(on: req.db).map {landmark}
    }
    
    // Returns all landmarks with their classrooms
    app.get("Landmarks"){req in
        Landmark.query(on: req.db).with(\.$classRoomsId).all()
    }
    
    // Return a landmark by ID
    app.get("Landmarks", ":LandMarkID") {req -> EventLoopFuture<Landmark> in
        Landmark.find(req.parameters.get("LandMarkID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    // Update a landmark
    app.put("Landmarks"){req -> EventLoopFuture<HTTPStatus> in
        let landmark = try req.content.decode(Landmark.self)
        return Landmark.find(landmark.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.landMarkName = landmark.landMarkName;
                $0.description = landmark.description;
                $0.hours = landmark.hours;
                $0.coordinatesLat = landmark.coordinatesLat;
                $0.coordinatesLon = landmark.coordinatesLon;
                $0.buildingType = landmark.buildingType;
                $0.icon = landmark.icon;
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    // Delete a landmark
    app.delete("Landmarks", ":LandMarkID"){ req -> EventLoopFuture<HTTPStatus> in
        Landmark.find(req.parameters.get("LandMarkID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.delete(on: req.db)
            }.transform(to: .ok)
    }
    
    // Creates a Classroom
    app.post("ClassRoom"){req -> EventLoopFuture<ClassRoom> in
        let classRoom = try req.content.decode(ClassRoom.self)
        return classRoom.create(on: req.db).map {classRoom}
    }
    
    // Get all Classrooms
    app.get("ClassRoom"){req in
        ClassRoom.query(on: req.db).all()
    }
    
    // Get a Classroom by ID
    app.get("ClassRoom", ":RoomID") {req -> EventLoopFuture<ClassRoom> in
        ClassRoom.find(req.parameters.get("RoomID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    // Update a classroom
    app.put("ClassRoom"){req -> EventLoopFuture<HTTPStatus> in
        let classRoom = try req.content.decode(ClassRoom.self)
        return ClassRoom.find(classRoom.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.classRoomsId = classRoom.classRoomsId;
                $0.roomNumber = classRoom.roomNumber;
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    // Delete a classroom
    app.delete("ClassRoom", ":RoomID"){ req -> EventLoopFuture<HTTPStatus> in
        ClassRoom.find(req.parameters.get("RoomID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.delete(on: req.db)
            }.transform(to: .ok)
    }
    
    // Creates a Studyroom
    app.post("StudyRooms"){req -> EventLoopFuture<StudyRoom> in
        let studyRooms = try req.content.decode(StudyRoom.self)
        return studyRooms.create(on: req.db).map {studyRooms}
    }
    
    // Get all StudyRooms
    app.get("StudyRooms"){req in
        StudyRoom.query(on: req.db).all()
    }
    
    // Get a StudyRoom by ID
    app.get("StudyRooms", ":StudyRoomID") {req -> EventLoopFuture<StudyRoom> in
        StudyRoom.find(req.parameters.get("StudyRoomID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    // Update a StudyRoom
    app.put("StudyRooms"){req -> EventLoopFuture<HTTPStatus> in
        let studyRoom = try req.content.decode(StudyRoom.self)
        return StudyRoom.find(studyRoom.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.classRoomsId = studyRoom.classRoomsId;
                $0.name = studyRoom.name;
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    // Delete a StudyRoom
    app.delete("StudyRooms", ":StudyRoomID"){ req -> EventLoopFuture<HTTPStatus> in
        StudyRoom.find(req.parameters.get("StudyRoomID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.delete(on: req.db)
            }.transform(to: .ok)
    }
    
    // Creates a User
    app.post("Users"){req -> EventLoopFuture<User> in
        let user = try req.content.decode(User.self)
        return user.create(on: req.db).map {user}
    }
    
    // Get all Users
    app.get("Users"){req in
        User.query(on: req.db).all()
    }
    
    // Get a Users by ID
    app.get("Users", ":UserID") {req -> EventLoopFuture<User> in
        User.find(req.parameters.get("UserID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    // Update a User
    app.put("Users"){req -> EventLoopFuture<HTTPStatus> in
        let user = try req.content.decode(User.self)
        return User.find(user.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.firstName = user.firstName;
                $0.studyRoomId = user.studyRoomId;
                $0.creation = user.creation;
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    // Delete a User
    app.delete("Users", ":UserID"){ req -> EventLoopFuture<HTTPStatus> in
        User.find(req.parameters.get("UserID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.delete(on: req.db)
            }.transform(to: .ok)
    }
}
