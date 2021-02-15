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
        VStack (alignment: .center) {
            HStack{
                Image(systemName: "mappin.and.ellipse")
                Text(building)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }

            Text("")
            Text("What would you like to do?")
            
            let options = ["Find/Create Study Group", "Go to Class", "Find Another Location"]
            List(options, id: \.self) { option in
                NavigationLink(destination: BuildingPopUpView(building: building)) {
                    Text(option)
                }
            }
        }
    }
}

struct BuildingPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        let samplePreviewBuilding = "Building 1"
        BuildingPopUpView(building: samplePreviewBuilding)
    }
}
