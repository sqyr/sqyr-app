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
    
    @Published var landMarks: [Landmark] = [Landmark]()
    @Published var classRooms: [Classroom] = [Classroom]()
    @Published var studyRooms: [Studyroom] = [Studyroom]()
    @Published var users: [User] = [User]()
    
    // This is just an example of a possible function.
    // List all other functions in here for data manipulation.
    static func saveLandmark(landMarkName: String, description: String, hours: String, coordinatesLat: Double, coordinatesLon: Double, buildingType: String, icon: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://sqyr.davidbarsam.com/Landmarks") else {
            fatalError("URL is not defined")
        }

        let landMark = Landmark(landMarkName: landMarkName, description: description, hours: hours, coordinatesLat: coordinatesLat, coordinatesLon: coordinatesLon, buildingType: buildingType, icon: icon)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(landMark)

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
    
    func getAllLandmarks(){
        guard let url = URL(string: "https://sqyr.davidbarsam.com/Landmarks") else{
            fatalError("URL is not defined.")
        }
        URLSession.shared.dataTask(with: url){data, response, error in
            guard let data = data, error == nil else{
                return
            }
            
            let landmarks = try? JSONDecoder().decode([Landmark].self, from: data)
            if let landmarks = landmarks{
                DispatchQueue.main.async{
                    self.landMarks = landmarks
                }
            }
        }.resume()
    }
    
    func getAllStudyRooms(){
        guard let url = URL(string: "https://sqyr.davidbarsam.com/Studyrooms") else{
            fatalError("URL is not defined.")
        }
        URLSession.shared.dataTask(with: url){data, repsonse, error in
            guard let data = data, error == nil else{
                return
            }
            let studyrooms = try? JSONDecoder().decode([Studyroom].self, from: data)
            if let studyrooms = studyrooms{
                DispatchQueue.main.async {
                    self.studyRooms = studyrooms
                }
            }
        }.resume()
    }
    
    func getAllUsers(){
        guard let url = URL(string: "https://sqyr.davidbarsam.com/Users") else{
            fatalError("URL is not defined.")
        }
        URLSession.shared.dataTask(with: url){data, response, error in
            guard let data = data, error == nil else{
                return
            }
            let users = try? JSONDecoder().decode([User].self, from: data)
            if let users = users{
                DispatchQueue.main.async {
                    self.users = users
                }
            }
        }.resume()
    }
    
    func saveClassroom(classRoom: Classroom, completion: @escaping (Bool) -> Void){
        guard let url = URL(string: "https://sqyr.davidbarsam.com/ClassRoom") else {
            fatalError("URL is not defined")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(classRoom)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let _ = data, error == nil else {
                return completion(false)
            }
            completion(true)
        }.resume()
    }
    
    static func saveStudyRoom(studyRoom: Studyroom, completion: @escaping (Bool) -> Void){
        guard let url = URL(string: "https://sqyr.davidbarsam.com/Studyrooms") else{
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
    
    func saveUser(user: User, completion: @escaping (Bool) -> Void){
        guard let url = URL(string: "https://sqyr.davidbarsam.com/Users") else {
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
    
    func getClassroomsByLandmark(landMark: Landmark){
        guard let uuid = landMark.id,
              let url = URL(string: "https://sqyr.davidbarsam.com/Landmarks/\(uuid)") else {
            fatalError("URL is not defined")
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            let decodedClassrooms = try? JSONDecoder().decode([Classroom].self, from: data)
            
            if let decodedClassrooms = decodedClassrooms{
                DispatchQueue.main.async {
                    self.classRooms = decodedClassrooms
                }
            }
        }.resume()
    }
    
    func deleteStudyRoom(studyRoom: Studyroom, completion: @escaping (Bool) -> Void){
        guard let url = URL(string: "https://sqyr.davidbarsam.com/StudyRoom/\(String(describing: studyRoom.id))") else{
            fatalError("URL is not defined.")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request){ data, _, error in
            guard let _ = data, error == nil else{
                return completion(false)
            }
            completion(true)
        }.resume()
    }
    
    func deleteUser(user: User, completion: @escaping (Bool) -> Void){
        guard let url = URL(string: "https://sqyr.davidbarsam.com/Users/\(String(describing: user.id))") else{
            fatalError("URL is not defined")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request){data, _, error in
            guard let _ = data, error == nil else{
                return completion(false)
            }
            completion(true)
        }.resume()
    }
}
