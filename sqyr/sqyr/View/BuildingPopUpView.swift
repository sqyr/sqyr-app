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
            VStack {
                // TITLE
                HStack{
                    Image(systemName: "mappin.and.ellipse")
                        .imageScale(.large)
                    Text(building)
                        .font(.title)
                        .fontWeight(.bold)
                } //: HSTACK
                
                // BUILDING HOURS
                BuildingHoursView()
                    .padding()
                    .cornerRadius(12)
                
                // OPTIONAL TITLE
                HStack {
                    Image(systemName: "questionmark.circle.fill")
                        .imageScale(.large)
                    Text("What would you like to do?")
                        .font(.title3)
                        .fontWeight(.bold)
                } //: HSTACK
                
                // OPTITIONAL ACTIONS
                let options = ["Join/Create a Study Group", "Find My Classroom"]
                
                List {
                    NavigationLink(destination: BuildingPopUpView(building: "TEGR")) {
                        Text(options[0])
                    } //: LINK
                    .padding(.vertical, 4)
                    .padding(.horizontal)
                    
                    NavigationLink(destination: BuildingPopUpView(building: "TEGR")) {
                        Text(options[1])
                    } //: LINK
                    .padding(.vertical, 4)
                    .padding(.horizontal)
                } //: LIST
                
                // INFORMATION TITLE
                HStack {
                    Image(systemName: "info.circle.fill")
                        .imageScale(.large)
                    Text("Did you know?")
                        .font(.title3)
                        .fontWeight(.bold)
                } //: HSTACK
                .padding(.vertical, 5)
                
                // INFORMATION TEXT
                Text("CBU's engineering building is home of the university's rapidly growing School of Engineering. The building features a mixture of classrooms and labs where students learn how to harness the power of technology to overcome real-world challenges.")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal)
                
            } //: VSTACK
            .navigationBarHidden(true)
            .padding(.top, 50)
            .padding(.bottom, 70)
        } //: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct BuildingPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        let samplePreviewBuilding = "TEGR"
        BuildingPopUpView(building: samplePreviewBuilding)
    }
}
