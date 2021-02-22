//
//  onboardingHelpView.swift
//  sqyr
//
//  Created by Steven Phun on 2/22/21.
//

import SwiftUI

var isOnboarding = true

struct onboardingHelpView: View {

    var body: some View {
        
        TabView {
            ForEach(0..<5) { item in
                VStack(spacing: 200) {
                    Text("Image \(item)")
                    
                    Text("help \(item)")
                    
                    Button(action: {isOnboarding = false }) {
                          HStack(spacing: 8) {
                              Text("Done")
                              
                              Image(systemName: "arrow.right.circle")
                                  .imageScale(.large)
                          }
                          .padding(.horizontal, 16)
                          .padding(.vertical, 10)
                          .background(
                              Capsule().strokeBorder(Color.white, lineWidth: 1.25))
                      }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .padding(.vertical, 20)
    }
}

struct onboardingHelpView_Previews: PreviewProvider {
    static var previews: some View {
        onboardingHelpView()
            .preferredColorScheme(.dark)
    }
}
