//
//  StudyRoom.swift
//  sqyr
//
//  Created by David Barsamian on 4/12/21.
//

import Foundation

struct StudyRoom: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case classRoomId
        case name
        case usersInStudyRoom
    }
    
    var id: Int?
    var classRoomId: ClassRoom?
    var name: String?
    var usersInStudyRoom: [User]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decodeIfPresent(Int.self, forKey: .id)
        classRoomId = try? container.decodeIfPresent(ClassRoom.self, forKey: .classRoomId)
        name = try? container.decodeIfPresent(String.self, forKey: .name)
        usersInStudyRoom = try? container.decodeIfPresent([User].self, forKey: .usersInStudyRoom)
    }
}
