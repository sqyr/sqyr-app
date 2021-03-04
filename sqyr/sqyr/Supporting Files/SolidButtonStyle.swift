//
//  SolidButtonStyle.swift
//  sqyr
//
//  Created by David Barsamian on 3/3/21.
//

import SwiftUI

struct SolidButtonStyle: ButtonStyle {
    var backgroundColor: Color
    var foregroundColor: Color
    var width: CGFloat?
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: 60)
            .background(RoundedRectangle(cornerRadius: 10.0, style: .continuous).fill(backgroundColor).opacity(configuration.isPressed ? 0.7 : 1))
            .foregroundColor(foregroundColor)
    }
}
