//
//  Constant.swift
//  sqyr
//
//  Created by Steven Phun on 3/1/21.
//

import SwiftUI

// MARK: - COLOR

let backgroundColor: UIColor = #colorLiteral(red: 0.001423736219, green: 0.1422029138, blue: 0.3297581077, alpha: 1)
let accentColor: UIColor = #colorLiteral(red: 1, green: 0.801191628, blue: 0, alpha: 1)
let extraColor1: UIColor = #colorLiteral(red: 0.6398844123, green: 0.4558349252, blue: 0, alpha: 1)
let extraColor2: UIColor = #colorLiteral(red: 0.6752929091, green: 0.2683526278, blue: 0.1159734204, alpha: 1)

// MARK: - IMAGE

func floorPlanImage(building: String, floor: Int) -> String {
    return "\(building)_Floor\(floor)"
}


