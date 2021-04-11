
// Below are all different types of requests that can be made to our database.

import Fluent
import Vapor

func routes(_ app: Application) throws {
    let landmarkController = LandmarkController()
    let classroomController = ClassroomController()
    let studyroomController = StudyroomController()
    let userController = UserController()
    
    // localhost:8080/Landmarks GET all landmarks
    app.get("Landmarks", use: landmarkController.all)
    
    // localhost:8080/Landmarks/# GET a landmark by ID
    app.get("Landmarks", ":LandMarkID", use: landmarkController.byID)
    
    // localhost:8080/ClassRoom GET all classrooms
    app.get("ClassRoom", use: classroomController.all)
    
    // localhost:8080/ClassRoom/# GET a classroom by ID
    app.get("ClassRoom", ":RoomID", use: classroomController.byID)
    
    // localhost:8080/StudyRooms GET all studyrooms
    app.get("StudyRooms", use: studyroomController.all)
    
    // localhost:8080/StudyRooms GET a studyroom by ID
    app.get("StudyRooms", ":StudyRoomID", use: studyroomController.byID)
    
    // localhost:8080/Users GET all users
    app.get("Users", use: userController.all)
    
    // localhost:8080/Users GET a user by ID
    app.get("Users", ":UserID", use: userController.byID)
    
    // localhost:8080/Landmarks POST a new landmark
    app.post("Landmarks", use: landmarkController.create)
    
    // localhost:8080/ClassRoom POST a new classroom
    app.post("ClassRoom", use: classroomController.create)
    
    // localhost:8080/StudyRooms POST a new studyroom
    app.post("StudyRooms", use: studyroomController.create)
    
    // localhost:8080/Users POST a new user
    app.post("Users", use: userController.create)
    
    // localhost:8080/Landmarks/:landmarkId/ClassRoom GET
    app.get("Landmarks", ":LandMarkID", "ClassRoom", use: classroomController.getByLandmarkId)
    
    // localhost:8080/ClassRoom/:RoomID/Studyrooms GET
    app.get("ClassRoom", ":RoomID", "StudyRooms", use: studyroomController.getByClassRoomId)
    
    // localhost:8080/Studyrooms/:StudyRoomID/Users GET
    app.get("StudyRooms", ":StudyRoomID", "Users", use: userController.getByStudyroomId)
    
    // localhost:8080/StudyRooms/:StudyRoomID DELETE a studyroom
    app.delete("StudyRooms", ":StudyRoomID", use: studyroomController.delete)
    
    // localhost:8080/Users/:UserID DELETE a user
    app.delete("Users", ":UserID", use: userController.delete)
    
    // Update a landmark
    // localhost:8080/Landmarks/#
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
    
    // Update a classroom
    // localhost:8080/ClassRoom/#
    app.put("ClassRoom"){req -> EventLoopFuture<HTTPStatus> in
        let classRoom = try req.content.decode(ClassRoom.self)
        return ClassRoom.find(classRoom.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.landmark = classRoom.landmark;
                $0.roomNumber = classRoom.roomNumber;
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    // Update a StudyRoom
    // localhost:8080/StudyRooms/#
    app.put("StudyRooms"){req -> EventLoopFuture<HTTPStatus> in
        let studyRoom = try req.content.decode(StudyRoom.self)
        return StudyRoom.find(studyRoom.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap{
                $0.classRoomId = studyRoom.classRoomId;
                $0.name = studyRoom.name;
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    // Update a User
    // localhost:8080/Users/#
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
}
