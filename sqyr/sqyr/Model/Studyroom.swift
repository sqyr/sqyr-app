//
//  Studyroom.swift
//
//  Created by Sqyr on 4/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Studyroom: Codable {

  enum CodingKeys: String, CodingKey {
    case name = "name"
    case classRoomId = "classRoomId"
    case id = "id"
  }

  var name: String?
  var classRoomId: ClassRoomId?
  var id: Int?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    classRoomId = try container.decodeIfPresent(ClassRoomId.self, forKey: .classRoomId)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
  }

}
