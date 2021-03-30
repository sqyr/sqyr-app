//
//  File.swift
//  
//
//  Created by Tomas Perez on 3/11/21.
//

import Foundation
import Vapor
import Fluent
import FluentPostgresDriver

final class User: Model, Content{
    
    static let schema = "Users"
    
    @ID(custom: "UserID")
    var id: Int?
    
    @Field(key: "FirstName")
    var firstName: String
    
    @Parent(key: "StudyRoomID")
    var studyRoomId: StudyRoom
    
    @Field(key: "Creation")
    var creation: Date
    
    init(){}
    
    init(id: Int? = nil, firstName: String, studyRoomId: Int, creation: Date){
        self.id = id
        self.firstName = firstName
        self.$studyRoomId.id = studyRoomId
        self.creation = creation
    }
}
