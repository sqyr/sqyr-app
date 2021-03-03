//
//  BuildingPopUpView.swift
//  sqyr
//
//  Created by Steven Phun on 2/10/21.
//

import SwiftUI

struct BuildingPopUpView: View {
    let building: String
    
    @State var isShowingCredits : Bool = false
    
    var body: some View {

            VStack(spacing: 10) {
                // BUILDING HOURS TITLE
                TitleView(icon: "building.2.crop.circle.fill", title: building)
                
                // BUILDING HOURS CONTENT
                BuildingHoursView()
                    .padding(.bottom)
                    .cornerRadius(12)
                
                // OPTIONAL ACTION TITLE
                TitleView(icon: "questionmark.circle.fill", title: "What would you like to do?")
                
                // OPTIONAL ACTION CONTENT
                List {
                    NavigationLink(destination: StudyGroupView(building:building, globalModel: GlobalModel())) {
                        Text("Join/Create a Study Group")
                    } //: LINK
                    .padding(.vertical, 4)
                    
                    NavigationLink(destination: LocateClassroomView(building: "TEGR")) {
                        Text("Find My Classroom")
                    } //: LINK
                    .padding(.vertical, 4)
                } //: List
                
                // BUILDING INFORMATION TITLE
                TitleView(icon: "info.circle.fill", title: "Did you know?")
                    .padding(.vertical, 5)
                
                // BUILDING INFORMATION CONTENT
                Text("CBU's engineering building is home of the university's rapidly growing School of Engineering. The building features a mixture of classrooms and labs where students learn how to harness the power of technology to overcome real-world challenges.")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 50) // FIXME: SwiftUI List
                
            } //: VSTACK
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

struct BuildingPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        let samplePreviewBuilding = "TEGR"
        BuildingPopUpView(building: samplePreviewBuilding)
    }
}
