//
//  EffectViewRepresentable.swift
//  sqyr
//
//  Created by Lucas Zischka.
//  Copyright © 2021 Lucas Zischka. All rights reserved.
//

import SwiftUI

struct EffectViewRepresentable: UIViewRepresentable {
    internal var effect: UIVisualEffect
    
    internal func makeUIView(context: Context) -> UIVisualEffectView {
        let effectView = UIVisualEffectView(effect: self.effect)
        return effectView
    }
    
    internal func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        //
    }
}
