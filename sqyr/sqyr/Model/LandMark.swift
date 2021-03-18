//
//  LandMark.swift
//  sqyr
//
//  Created by Tomas Perez on 3/17/21.
//

import Foundation

struct Landmark: Codable{
    var id: Int?
    var landMarkName: String
    var description: String
    var hours: String
    var coordinatesLat: Double
    var coordinatesLon: Double
    var buildingType: String
    var icon: String
}
