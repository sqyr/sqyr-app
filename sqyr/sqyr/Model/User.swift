//
//  User.swift
//  sqyr
//
//  Created by David Barsamian on 4/12/21.
//

import Foundation

struct User: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case studyRoomId
        case creation
    }
    
    var id: Int?
    var firstName: String?
    var studyRoomId: StudyRoom?
    var creation: Date?
    
    // JSON Decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decodeIfPresent(Int.self, forKey: .id)
        firstName = try? container.decodeIfPresent(String.self, forKey: .firstName)
        studyRoomId = try? container.decodeIfPresent(StudyRoom.self, forKey: .studyRoomId)
        creation = try? container.decodeIfPresent(Date.self, forKey: .creation)
    }
    
    // Creation In-App
    init(firstName: String, studyRoomId: StudyRoom?) {
        self.firstName = firstName
        self.studyRoomId = studyRoomId
    }
}
