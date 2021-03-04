//
//  BuildingPopUpView.swift
//  sqyr
//
//  Created by Steven Phun on 2/10/21.
//

import SwiftUI

struct LandmarkDetail: View {
    let building: String
    
    @State var isShowingCredits: Bool = false
    
    var body: some View {
        ScrollView(.vertical) {
            // BUILDING HOURS TITLE
            Label(
                title: { Text(building).font(.title2).bold() },
                icon: { Image(systemName: "building.2.crop.circle.fill").font(.title2) }
            )
                
            // BUILDING HOURS CONTENT
            BuildingHoursView()
            
            // BUILDING INFORMATION CONTENT
            Text("About").font(.title3).bold()
            
            GroupBox {
                Text("The College of Engineering building is a 100,670 square-foot, 3-story with an accessible rooftop area with a solar-thermal lab. Within the building are 45 classroom/teaching areas contained in two blocks.")
                    .font(.body)
            }
                
            // OPTIONAL ACTION TITLE
            // LandmarkTitleView(icon: "questionmark.circle.fill", title: "What would you like to do?")
                
            // OPTIONAL ACTION CONTENT
            HStack {
                Spacer()
                NavigationLink(destination: StudyGroupView(building: building, globalModel: GlobalModel())) {
                    Text("Study Groups")
                } //: LINK
                .padding(.vertical, 4)
                Spacer()
                NavigationLink(destination: LocateClassroomView(building: "TEGR")) {
                    Text("Find My Classroom")
                } //: LINK
                .padding(.vertical, 4)
                Spacer()
            }
        } //: SCROLLVIEW
        .padding()
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(
            trailing:
            Button(action: {
                isShowingCredits = true
            }) {
                Image(systemName: "person.2")
            } //: BUTTON
            .sheet(isPresented: $isShowingCredits) {
                CreditView()
            } //: SHEET
        ) //: ITEM
    }
}

struct LandmarkTitleView: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .imageScale(.large)
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
        } //: HSTACK
    }
}

struct BuildingPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        let samplePreviewBuilding = "TEGR"
        LandmarkDetail(building: samplePreviewBuilding)
    }
}
