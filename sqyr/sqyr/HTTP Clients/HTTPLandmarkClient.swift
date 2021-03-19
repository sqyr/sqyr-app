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
    // This is just an example of a possible function.
    // List all other functions in here for data manipulation.
    static func saveLandmark(landMarkName: String, description: String, hours: String, coordinatesLat: Double, coordinatesLon: Double, buildingType: String, icon: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:8080/Landmarks") else {
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
}
