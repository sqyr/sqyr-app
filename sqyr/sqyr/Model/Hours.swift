//
//  Hours.swift
//
//  Created by Sqyr on 4/12/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Hours: Codable {
    enum CodingKeys: String, CodingKey {
        case sun
        case sat
        case fri
        case thu
        case wed
        case tue
        case mon
    }

    var sun: String?
    var sat: String?
    var fri: String?
    var thu: String?
    var wed: String?
    var tue: String?
    var mon: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sun = try container.decodeIfPresent(String.self, forKey: .sun)
        sat = try container.decodeIfPresent(String.self, forKey: .sat)
        fri = try container.decodeIfPresent(String.self, forKey: .fri)
        thu = try container.decodeIfPresent(String.self, forKey: .thu)
        wed = try container.decodeIfPresent(String.self, forKey: .wed)
        tue = try container.decodeIfPresent(String.self, forKey: .tue)
        mon = try container.decodeIfPresent(String.self, forKey: .mon)
    }
}
