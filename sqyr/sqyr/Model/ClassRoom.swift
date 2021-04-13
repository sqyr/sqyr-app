//
//  ClassRoom.swift
//  sqyr
//
//  Created by David Barsamian on 4/12/21.
//

import Foundation

struct ClassRoom: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case landmark
        case roomNumber
        case studyRoomsId
    }
    
    var id: Int?
    var landmark: Landmark?
    var roomNumber: Int?
    var studyRoomsId: [StudyRoom]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decodeIfPresent(Int.self, forKey: .id)
        landmark = try? container.decodeIfPresent(Landmark.self, forKey: .landmark)
        roomNumber = try? container.decodeIfPresent(Int.self, forKey: .roomNumber)
        studyRoomsId = try? container.decodeIfPresent([StudyRoom].self, forKey: .studyRoomsId)
    }
}
