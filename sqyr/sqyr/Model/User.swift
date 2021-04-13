//
//  User.swift
//
//  Created by Sqyr on 4/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct User: Codable {

  enum CodingKeys: String, CodingKey {
    case studyRoomId = "studyRoomId"
    case firstName = "firstName"
    case creation = "creation"
    case id = "id"
  }

  var studyRoomId: StudyRoomId?
  var firstName: String?
  var creation: String?
  var id: Int?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    studyRoomId = try container.decodeIfPresent(StudyRoomId.self, forKey: .studyRoomId)
    firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
    creation = try container.decodeIfPresent(String.self, forKey: .creation)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
  }

}
