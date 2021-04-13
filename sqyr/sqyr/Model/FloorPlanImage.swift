//
//  FloorPlanImage.swift
//
//  Created by Sqyr on 4/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct FloorPlanImage: Codable {
    enum CodingKeys: String, CodingKey {
        case basement
        case level1
        case level2
        case level3
        case level4
    }

    var basement: String?
    var level1: String?
    var level2: String?
    var level3: String?
    var level4: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        basement = try container.decodeIfPresent(String.self, forKey: .basement)
        level1 = try container.decodeIfPresent(String.self, forKey: .level1)
        level2 = try container.decodeIfPresent(String.self, forKey: .level2)
        level3 = try container.decodeIfPresent(String.self, forKey: .level3)
        level4 = try container.decodeIfPresent(String.self, forKey: .level4)
    }
}
