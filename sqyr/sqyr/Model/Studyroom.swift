//
//  Studyroom.swift
//  sqyr
//
//  Created by Tomas Perez on 3/17/21.
//

import Foundation

struct Studyroom: Codable{
    var id: Int?
    var classRoomsId: Classroom
    var name: String
}