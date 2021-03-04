//
//  OnboardingView.swift
//  sqyr
//
//  Created by David Barsamian on 3/1/21.
//

import SwiftUI


struct OnboardingView: View {
    @State var showingPerms: Bool = false
    private let constWidth: CGFloat = UIScreen.main.bounds.width * 0.8

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: UIScreen.main.bounds.height * 0.15)
            Text("Welcome to Sqyr")
                .font(.largeTitle)
                .fontWeight(.black)
                .tracking(-1.0)
                .lineLimit(1)
            Spacer().frame(height: 15)
            VStack {
                OnboardingDetail(systemName: "figure.walk", header: "Get Directions", desc: "Discover important places on campus, like classrooms.", color: .blue)
                OnboardingDetail(systemName: "mappin.and.ellipse", header: "View Landmark Info", desc: "Check building and restaurant hours, and more.", color: .red)
                OnboardingDetail(systemName: "person.3.fill", header: "Create & Find Groups", desc: "Meet with peers to get stuff done.", color: .purple)
            }
            Spacer()
            Button("Next") {
                showingPerms = true
                presentationMode.wrappedValue.dismiss()
            }
            .buttonStyle(SolidButtonStyle(backgroundColor: .blue, foregroundColor: .white, width: constWidth))
            Spacer()
                .frame(height: UIScreen.main.bounds.height * 0.05)
        }
        .frame(width: constWidth)
        .JMAlert(showModal: $showingPerms, for: [.camera, .location], autoDismiss: true, onAppear: {}, onDisappear: {
            presentationMode.wrappedValue.dismiss()
        })
    }
}

private struct OnboardingDetail: View {
    var systemName: String
    var header: String
    var desc: String
    var color: Color

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: systemName)
                .renderingMode(.template)
                .foregroundColor(color)
                .font(.largeTitle)
                .frame(width: 80)
            VStack(alignment: .leading) {
                Text(header)
                    .font(.headline)
                Text(desc)
                    .font(.body)
            }
            Spacer()
        }
        .padding(.vertical, 10)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
