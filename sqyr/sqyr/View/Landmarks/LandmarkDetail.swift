//
//  BuildingPopUpView.swift
//  sqyr
//
//  Created by Steven Phun on 2/10/21.
//

import SwiftUI

struct LandmarkDetail: View {
    let landmark: LandmarkJson
    @State var isShowingCredits: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            // BUILDING HOURS TITLE
            LandmarkTitleView(icon: landmark.icon, title: landmark.name)
                
            // BUILDING HOURS CONTENT
            BuildingHoursView(landmark: landmark)
            
            // BUILDING INFORMATION CONTENT
            LandmarkTitleView(icon: "info.circle.fill", title: "About")
            
            GroupBox {
                Text(landmark.description)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
                
            // OPTIONAL ACTION TITLE
            if landmark.studyGroups != nil && landmark.floorPlanImage != nil {
                LandmarkTitleView(icon: "ellipsis.circle.fill", title: "Actions")
            }
                
            // OPTIONAL ACTION CONTENT
            HStack {
                // STUDY GROUP BUTTON
                if landmark.studyGroups != nil {
                    Spacer()
                    NavigationLink(destination: StudyGroupView(landmark: landmark, globalModel: GlobalModel())) {
                        Text("Study Groups")
                            .padding()
                    }
                    .buttonStyle(SolidButtonStyle(backgroundColor: Color("blue"), foregroundColor: .white))
                }
                
                // FLOOR PLAN BUTTON
                if landmark.floorPlanImage != nil {
                    Spacer()
                    NavigationLink(destination: LocateClassroomView(landmark: landmark)) {
                        Text("Find My Classroom")
                            .padding()
                    }
                    .buttonStyle(SolidButtonStyle(backgroundColor: Color("blue"), foregroundColor: .white))
                    Spacer()
                }
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
                Image(systemName: "paperclip")
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
        .foregroundColor(Color("gold"))
        .padding()
    }
}

struct BuildingPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: landmarks[0])
        LandmarkDetail(landmark: landmarks[3])
    }
}
