//
//  File.swift
//
//
//  Created by Tomas Perez on 3/10/21.
//

import Foundation
import Fluent
import FluentPostgresDriver
import Vapor

final class Landmark: Model, Content{
    static let schema = "LandMarks"
    
    @ID(custom: "LandMarkID")
    var id: Int?
    
    @Field(key: "LandMarkName")
    var landMarkName: String
    
    @Field(key: "Description")
    var description: String
    
    @Field(key: "Hours")
    var hours: String
    
    @Field(key: "CoordinatesLat")
    var coordinatesLat: Double
    
    @Field(key: "CoordinatesLon")
    var coordinatesLon: Double
    
    @Field(key: "BuildingType")
    var buildingType: String
    
    @Field(key: "Icon")
    var icon: String
    
    @Children(for: \.$classRoomsId)
    var classRoomsId: [ClassRoom]
    
    init() {}
    
    init(id: Int? = nil, landMarkName: String, description: String, hours: String, coordinatesLat: Double, coordinatesLon: Double, buildingType: String, icon: String){
        self.id = id
        self.landMarkName = landMarkName
        self.description = description
        self.hours = hours
        self.coordinatesLat = coordinatesLat
        self.coordinatesLon = coordinatesLon
        self.buildingType = buildingType
        self.icon = icon
    }
}