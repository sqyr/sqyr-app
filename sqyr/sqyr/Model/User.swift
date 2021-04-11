//
//  User.swift
//  sqyr
//
//  Created by Tomas Perez on 3/17/21.
//

import Foundation

struct User: Codable{
    var id: Int?
    var firstName: String
    var studyRoomId: Studyroom?
    var creation: String
}
    
