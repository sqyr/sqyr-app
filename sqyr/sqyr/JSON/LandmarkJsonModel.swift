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
    var getHours: [LandMarkHours] {
        [LandMarkHours(dayOfWeek: "Monday", openHours: hours.mon ?? "Closed"),
         LandMarkHours(dayOfWeek: "Tuesday", openHours: hours.tue ?? "Closed"),
         LandMarkHours(dayOfWeek: "Wednesday", openHours: hours.wed ?? "Closed"),
         LandMarkHours(dayOfWeek: "Thursday", openHours: hours.thu ?? "Closed"),
         LandMarkHours(dayOfWeek: "Friday", openHours: hours.fri ?? "Closed"),
         LandMarkHours(dayOfWeek: "Saturday", openHours: hours.sat ?? "Closed"),
         LandMarkHours(dayOfWeek: "Sunday", openHours: hours.sun ?? "Closed"),
        ]
    }
    
    // MARK: - HELPER DATA MODEL
    struct CodableHoursJson: Codable {
        let mon: String?
        let tue: String?
        let wed: String?
        let thu: String?
        let fri: String?
        let sat: String?
        let sun: String?
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
    
    // MARK: - HELPER STRUCTS
    struct LandMarkHours {
        let dayOfWeek: String
        let openHours: String
    }
}

