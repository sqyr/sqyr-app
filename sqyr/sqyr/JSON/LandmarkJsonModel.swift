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
    let floorPlanImage: CodableFloorPlanImageJson?
    let rooms: CodableRoomsJson?
    let studyGroups: [String]?

    // MARK: - COMPUTED PROPERTIES
    var getHours: [LandmarkHours] {
        [LandmarkHours(dayOfWeek: "Monday", openHours: hours.mon ?? "Closed"),
         LandmarkHours(dayOfWeek: "Tuesday", openHours: hours.tue ?? "Closed"),
         LandmarkHours(dayOfWeek: "Wednesday", openHours: hours.wed ?? "Closed"),
         LandmarkHours(dayOfWeek: "Thursday", openHours: hours.thu ?? "Closed"),
         LandmarkHours(dayOfWeek: "Friday", openHours: hours.fri ?? "Closed"),
         LandmarkHours(dayOfWeek: "Saturday", openHours: hours.sat ?? "Closed"),
         LandmarkHours(dayOfWeek: "Sunday", openHours: hours.sun ?? "Closed"),
        ]
    }
    
    var getFloorPlanImage: [LandmarkFloorPlanImage] {
        var images: [LandmarkFloorPlanImage] = []
        
        if floorPlanImage != nil {
            if floorPlanImage!.basement != nil {
                images.append(LandmarkFloorPlanImage(title: "Basement", image: floorPlanImage!.basement!))
            }
            
            if floorPlanImage!.level1 != nil {
                images.append(LandmarkFloorPlanImage(title: "Level 1", image: floorPlanImage!.level1!))
            }
            
            if floorPlanImage!.level2 != nil {
                images.append(LandmarkFloorPlanImage(title: "Level 2", image: floorPlanImage!.level2!))
            }
            
            if floorPlanImage!.level3 != nil {
                images.append(LandmarkFloorPlanImage(title: "Level 3", image: floorPlanImage!.level3!))
            }
            
            if floorPlanImage!.level4 != nil {
                images.append(LandmarkFloorPlanImage(title: "Level 4", image: floorPlanImage!.level4!))
            }
        }
        
        return images
    }
    
    var getLandmarkRoomNumbers : [Int] {
        let unwrapRooms = rooms!
        var array: [Int] = []
        
        if unwrapRooms.basementStart != nil && unwrapRooms.basementEnd != nil {
            for room in unwrapRooms.basementStart!...unwrapRooms.basementEnd! {
                array.append(room)
            }
        }
        
        if unwrapRooms.level1Start != nil && unwrapRooms.level1End != nil {
            for room in unwrapRooms.level1Start!...unwrapRooms.level1End! {
                array.append(room)
            }
        }
        
        if unwrapRooms.level2Start != nil && unwrapRooms.level2End != nil {
            for room in unwrapRooms.level2Start!...unwrapRooms.level2End! {
                array.append(room)
            }
        }
        
        if unwrapRooms.level3Start != nil && unwrapRooms.level3End != nil {
            for room in unwrapRooms.level3Start!...unwrapRooms.level3End! {
                array.append(room)
            }
        }
        
        if unwrapRooms.level4Start != nil && unwrapRooms.level4End != nil {
            for room in unwrapRooms.level4Start!...unwrapRooms.level4End! {
                array.append(room)
            }
        }
        
        return array
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
        let level1: String?
        let level2: String?
        let level3: String?
        let level4: String?
    }

    struct CodableRoomsJson: Codable {
        let basementStart: Int?
        let basementEnd: Int?
        let level1Start: Int?
        let level1End: Int?
        let level2Start: Int?
        let level2End: Int?
        let level3Start: Int?
        let level3End: Int?
        let level4Start: Int?
        let level4End: Int?
    }
    
    // MARK: - HELPER STRUCTS
    struct LandmarkHours {
        let dayOfWeek: String
        let openHours: String
    }
    
    struct LandmarkFloorPlanImage: Hashable {
        let title: String
        let image: String
    }
}

