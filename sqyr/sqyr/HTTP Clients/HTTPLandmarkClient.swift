//
//  HTTPLandmarkClient.swift
//  sqyr
//
//  Created by Tomas Perez on 3/17/21.
//

import Foundation

// To call this in the code, setup as such:
// HTTPLandmarkClient().saveLandmark(landMarkName: "", etc...){ success in
//      if success{
//          do something...
//      } else {
//          do something else or show error message
//      }
// }
class HTTPLandmarkClient: ObservableObject {
    static var shared = HTTPLandmarkClient()
    
    @Published var landMarks: [Landmark]? = [Landmark]()
    @Published var classRooms: [ClassRoom]? = [ClassRoom]()
    @Published var studyRooms: [StudyRoom]? = [StudyRoom]()
    @Published var users: [User]? = [User]()
    
    func getAllLandmarks() {
        guard let url = URL(string: "http://localhost:8080/Landmarks") else {
            fatalError("URL is not defined.")
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            let landmarks = try? JSONDecoder().decode([Landmark].self, from: data)
            if let landmarks = landmarks {
                DispatchQueue.main.async {
                    self.landMarks = landmarks
                }
            }
        }.resume()
    }
    
    func getAllClassRooms() {
        guard let url = URL(string: "http://localhost:8080/ClassRooms") else {
            fatalError("URL is not defined.")
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            let classrooms = try? JSONDecoder().decode([ClassRoom].self, from: data)
            if let classrooms = classrooms {
                DispatchQueue.main.async {
                    self.classRooms = classrooms
                }
            }
        }.resume()
    }
    
    func getAllStudyRooms() {
        guard let url = URL(string: "http://localhost:8080/StudyRooms") else {
            fatalError("URL is not defined.")
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            let studyrooms = try? JSONDecoder().decode([StudyRoom].self, from: data)
            if let studyrooms = studyrooms {
                DispatchQueue.main.async {
                    self.studyRooms = studyrooms
                }
            }
        }.resume()
    }
    
    func getAllUsers() {
        guard let url = URL(string: "http://localhost:8080/Users") else {
            fatalError("URL is not defined.")
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            let users = try? JSONDecoder().decode([User].self, from: data)
            if let users = users {
                DispatchQueue.main.async {
                    self.users = users
                }
            }
        }.resume()
    }
    
    func saveStudyRoom(studyRoom: StudyRoom, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:8080/StudyRooms") else {
            fatalError("URL is not defined.")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(studyRoom)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
    
    func saveUser(user: User, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:8080/Users") else {
            fatalError("URL is not defined")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(user)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
    
    func getClassRoomsByLandmark(landMark: Landmark) {
        guard let uuid = landMark.id,
              let url = URL(string: "http://localhost:8080/Landmarks/\(uuid)/ClassRoom")
        else {
            fatalError("URL is not defined")
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            let decodedClassRooms = try? JSONDecoder().decode([ClassRoom].self, from: data)
            
            if let decodedClassRooms = decodedClassRooms {
                DispatchQueue.main.async {
                    self.classRooms = decodedClassRooms
                }
            }
        }.resume()
    }
    
    func getStudyRoomsByClassRooms(classRoom: ClassRoom) {
        guard let id = classRoom.id,
              let url = URL(string: "http://localhost:8080/ClassRoom/\(id)/StudyRooms")
        else {
            fatalError("URL is not defined")
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            let decodedStudyRooms = try? JSONDecoder().decode([StudyRoom].self, from: data)
            
            if let decodedStudyRooms = decodedStudyRooms {
                DispatchQueue.main.async {
                    self.studyRooms = decodedStudyRooms
                }
            }
        }.resume()
    }
    
    // localhost:8080/StudyRooms/1/Users
    func getUsersByStudyRoom(studyRoom: StudyRoom) {
        guard let id = studyRoom.id,
              let url = URL(string: "http://localhost:8080/StudyRooms/\(id)/Users")
        else {
            fatalError("URL is not defined")
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            let decodedUsers = try? JSONDecoder().decode([User].self, from: data)
            
            if let decodedUsers = decodedUsers {
                DispatchQueue.main.async {
                    self.users = decodedUsers
                }
            }
        }
    }
    
    func deleteStudyRoom(studyRoom: StudyRoom, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:8080/StudyRooms/\(String(studyRoom.id!))") else {
            fatalError("URL is not defined.")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
    
    func deleteUser(user: User, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:8080/Users/\(String(user.id!))") else {
            fatalError("URL is not defined")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
}
