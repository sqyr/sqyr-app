//
//  ARView.swift
//  sqyr
//
//  Created by David Barsamian on 2/28/21.
//

import SwiftUI

struct ARView: View {
    var body: some View {
        return ARCLView()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ARView_Previews: PreviewProvider {
    static var previews: some View {
        ARView()
    }
}
