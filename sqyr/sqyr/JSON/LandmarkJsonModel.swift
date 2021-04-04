//
//  LandmarkJsonModel.swift
//  sqyr
//
//  Created by Steven Phun on 4/3/21.
//

import SwiftUI

// MARK: - LANDMARK DATA MODEL

struct LandmarkJson: Codable {
    
    // MARK: - STORED PROPERTIES
    let id: Int
    let name: String
    let description: String
    let hours: CodableHoursJson
    let lat: String
    let lon: String
    let type: String
    let image: String
    let showInfoLeft: Bool
    let icon: String
    let floorPlanImage: CodableFloorPlanImageJson
    let rooms: CodableRoomsJson
    let studyGroups: [String]

    // MARK: - COMPUTED PROPERTIES

    // MARK: - HELPER DATA MODEL

    struct CodableHoursJson: Codable {
        let monStart: String
        let monEnd: String
        let tueStart: String
        let tueEnd: String
        let wedStart: String
        let wedEnd: String
        let thuStart: String
        let thuEnd: String
        let friStart: String
        let friEnd: String
        let satStart: String?
        let satEnd: String?
        let sunStart: String?
        let sunEnd: String?
    }

    struct CodableFloorPlanImageJson: Codable {
        let basement: String?
        let level1: String
        let level2: String
        let level3: String
    }

    struct CodableRoomsJson: Codable {
        let basementStart: Int?
        let basementEnd: Int?
        let level1Start: Int
        let level1End: Int
        let level2Start: Int
        let level2End: Int
        let level3Start: Int
        let level3End: Int
        let level4Start: Int?
        let level4End: Int?
    }
}

