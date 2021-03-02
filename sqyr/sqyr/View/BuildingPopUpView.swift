//
//  BuildingPopUpView.swift
//  sqyr
//
//  Created by Steven Phun on 2/10/21.
//

import SwiftUI

struct BuildingPopUpView: View {
    let building: String
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // BUILDING HOURS TITLE
                BuildingTitleView(icon: "building.2.crop.circle.fill", title: building)
                
                // BUILDING HOURS CONTENT
                BuildingHoursView()
                    .padding(.horizontal)
                    .padding(.bottom)
                    .cornerRadius(12)
                
                // OPTIONAL ACTION TITLE
                BuildingTitleView(icon: "questionmark.circle.fill", title: "What would you like to do?")
                
                // OPTIONAL ACTION CONTENT
                List {
                    NavigationLink(destination: BuildingPopUpView(building: "TEGR")) {
                        Text("Join/Create a Study Group")
                    } //: LINK
                    .padding(.vertical, 4)
                    .padding(.horizontal)
                    
                    NavigationLink(destination: LocateClassroomView(building: "TEGR")) {
                        Text("Find My Classroom")
                    } //: LINK
                    .padding(.vertical, 4)
                    .padding(.horizontal)
                } //: LIST
                
                // BUILDING INFORMATION TITLE
                BuildingTitleView(icon: "info.circle.fill", title: "Did you know?")
                    .padding(.vertical, 5)
                
                // BUILDING INFORMATION CONTENT
                Text("CBU's engineering building is home of the university's rapidly growing School of Engineering. The building features a mixture of classrooms and labs where students learn how to harness the power of technology to overcome real-world challenges.")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal)
                
            } //: VSTACK
            .navigationBarHidden(true)
            .padding(.vertical)
            .padding(.bottom, 20) // FIXME: List is acting weird.
        } //: NAVIGATION
        .navigationBarTitle("", displayMode: .inline)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct BuildingPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        let samplePreviewBuilding = "TEGR"
        BuildingPopUpView(building: samplePreviewBuilding)
    }
}
