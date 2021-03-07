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
        ScrollView(.vertical, showsIndicators: false) {
            // BUILDING HOURS TITLE
            Label(
                title: { Text(building).font(.title2).bold() },
                icon: { Image(systemName: "building.2.crop.circle.fill").font(.title2) }
            )
                
            // BUILDING HOURS CONTENT
            BuildingHoursView()
            
            // BUILDING INFORMATION CONTENT
            Label(
                title: { Text("About").font(.title3).bold() },
                icon: { Image(systemName: "info.circle.fill").font(.title3) }
            )
            .padding()
            
            GroupBox {
                Text("The College of Engineering building is a 100,670 square-foot, 3-story with an accessible rooftop area with a solar-thermal lab.")
                    .fixedSize(horizontal: false, vertical: true)
            }
                
            // OPTIONAL ACTION TITLE
            Label(
                title: { Text("Actions").font(.title3).bold() },
                icon: { Image(systemName: "ellipsis.circle.fill").font(.title3) }
            )
            .padding()
                
            // OPTIONAL ACTION CONTENT
            HStack {
                Spacer()
                NavigationLink(destination: StudyGroupView(building: building, globalModel: GlobalModel())) {
                    Text("Study Groups")
                        .padding()
                }
                .buttonStyle(SolidButtonStyle(backgroundColor: .blue, foregroundColor: .white))
                Spacer()
                NavigationLink(destination: LocateClassroomView(building: "TEGR")) {
                    Text("Find My Classroom")
                        .padding()
                }
                .buttonStyle(SolidButtonStyle(backgroundColor: .purple, foregroundColor: .white))
                Spacer()
            }
            .padding(.bottom)
        } //: SCROLLVIEW
        .padding()
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(
            trailing:
            Button(action: {
                isShowingCredits = true
            }) {
                Image(systemName: "c.circle")
            } //: BUTTON
            .sheet(isPresented: $isShowingCredits) {
                CreditView()
            } //: SHEET
        ) //: ITEM
        .edgesIgnoringSafeArea(.bottom)
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
