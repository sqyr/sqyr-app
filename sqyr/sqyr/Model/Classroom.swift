//
//  Classroom.swift
//
//  Created by Sqyr on 4/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Classroom: Codable {

  enum CodingKeys: String, CodingKey {
    case roomNumber = "roomNumber"
    case landmark = "landmark"
    case id = "id"
  }

  var roomNumber: Int?
  var landmark: Landmark?
  var id: Int?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    roomNumber = try container.decodeIfPresent(Int.self, forKey: .roomNumber)
    landmark = try container.decodeIfPresent(Landmark.self, forKey: .landmark)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
  }

}
