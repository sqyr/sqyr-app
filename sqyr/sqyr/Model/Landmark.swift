//
//  Landmark.swift
//  sqyr
//
//  Created by David Barsamian on 4/12/21.
//

import Foundation

struct Landmark: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case landMarkName
        case description
        case hours
        case coordinatesLat
        case coordinatesLon
        case buildingType
        case icon
        case images
        case showInfoLeft
        case floorPlanImage
        case classRoomsId
    }
    
    var id: Int?
    var landMarkName: String?
    var description: String?
    var hours: Hours?
    var coordinatesLat: Double?
    var coordinatesLon: Double?
    var buildingType: String?
    var icon: String?
    var images: String?
    var showInfoLeft: Bool?
    var floorPlanImage: FloorPlanImage?
    var classRoomsId: [ClassRoom]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decodeIfPresent(Int.self, forKey: .id)
        landMarkName = try? container.decodeIfPresent(String.self, forKey: .landMarkName)
        description = try? container.decodeIfPresent(String.self, forKey: .description)
        hours = try? container.decodeIfPresent(Hours.self, forKey: .hours)
        coordinatesLat = try? container.decodeIfPresent(Double.self, forKey: .coordinatesLat)
        coordinatesLon = try? container.decodeIfPresent(Double.self, forKey: .coordinatesLon)
        buildingType = try? container.decodeIfPresent(String.self, forKey: .buildingType)
        icon = try? container.decodeIfPresent(String.self, forKey: .icon)
        images = try? container.decodeIfPresent(String.self, forKey: .images)
        showInfoLeft = try? container.decodeIfPresent(Bool.self, forKey: .showInfoLeft)
        floorPlanImage = try? container.decodeIfPresent(FloorPlanImage.self, forKey: .floorPlanImage)
        classRoomsId = try? container.decodeIfPresent([ClassRoom].self, forKey: .classRoomsId)
    }
}

struct FloorPlanImage: Codable {
    var basement: String?
    var level1: String?
    var level2: String?
    var level3: String?
    var level4: String?
}

struct Hours: Codable {
    var mon: String?
    var tue: String?
    var wed: String?
    var thu: String?
    var fri: String?
    var sat: String?
    var sun: String?
}
