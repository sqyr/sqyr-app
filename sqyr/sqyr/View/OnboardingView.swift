//
//  OnboardingView.swift
//  sqyr
//
//  Created by David Barsamian on 3/1/21.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome to Sqyr")
                .font(.largeTitle)
                .bold()
            Spacer().frame(height: 20)
            VStack {
                OnboardingDetail(systemName: "figure.walk", header: "Get Directions", desc: "Discover important places on campus, like classrooms.", color: .blue)
                OnboardingDetail(systemName: "mappin.and.ellipse", header: "", desc: <#T##String#>, color: <#T##Color#>)
            }
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width * 0.8)
    }
}

private struct OnboardingDetail: View {
    var systemName: String
    var header: String
    var desc: String
    var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: systemName)
                .renderingMode(.template)
                .foregroundColor(color)
                .font(.largeTitle)
                .padding()
            VStack(alignment: .leading) {
                Text(header)
                    .font(.headline)
                Text(desc)
                    .font(.body)
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
