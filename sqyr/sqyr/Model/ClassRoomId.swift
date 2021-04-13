//
//  ClassRoomId.swift
//
//  Created by Sqyr on 4/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct ClassRoomId: Codable {

  enum CodingKeys: String, CodingKey {
    case id = "id"
  }

  var id: Int?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
  }

}
