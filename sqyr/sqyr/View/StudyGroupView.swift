//
//  StudyGroupView.swift
//  sqyr
//
//  Created by Steven Phun on 3/2/21.
//

import SwiftUI

struct StudyGroupView: View {
    
    let building: String
    
    @State var text: String = ""
    @ObservedObject var globalModel: GlobalModel
    
    var body: some View {
        VStack {
            // SEARCH AVAILABLE ROOMS
            TitleView(icon: "", title: "Available Rooms")
            SearchBarView(text: $text, globalModel: globalModel)
            
            // SEARCH STUDY GROUPS
            TitleView(icon: "", title: "Study Groups")
            SearchBarView(text: $text, globalModel: globalModel)
            
            // DISPLAY ALL ROOMS
            TitleView(icon: "", title: "All \(building) Rooms")
                .padding(.top, 50)
            GroupBox {
                List {
                    ForEach(100..<150) { room in
                        let openHour = 1 + 12  // 12 hour format.
                        let closeHour = 10 + 12 // 12 hour format.
                        let time = Int.random(in: openHour...closeHour)
                        let hour12Format = time - 12
                        
                        HStack {
                            Text("\(room)")
                            Spacer()
                            Text("Open Until \(hour12Format)PM")
                                .font(.footnote)
                            Spacer()
                            Image(systemName: isRoomClosedIcon(hour: time))
                                .foregroundColor(isRoomClosedStatus(hour: time))
                        } //: HSTACK
                    } //: LOOP
                } //: LIST
                .padding(.vertical, 7)
            } //: BOX
            .padding()
        } //: VSTACK
        .padding(.top)
    }
}

func isClosed(hour:Int) -> Bool {
    let currentHour = Calendar.current.component(.hour, from: Date())
    
    return currentHour > 8 && currentHour < hour
}

func isRoomClosedStatus(hour: Int) -> Color {
    return isClosed(hour: hour) ? Color.green : Color.red
}

func isRoomClosedIcon(hour: Int) -> String {
    return isClosed(hour: hour) ? "circlebadge.fill" : "lock.circle.fill"
}


struct StudyGroupView_Previews: PreviewProvider {
    static var previews: some View {
        StudyGroupView(building: "TEGR", globalModel: GlobalModel())
    }
}
