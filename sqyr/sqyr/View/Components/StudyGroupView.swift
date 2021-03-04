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
            Group {
                // SEARCH STUDY GROUPS
                Text("Study Groups").font(.title2).bold().padding(.top)
                SearchBarView(text: $text, globalModel: globalModel)

                // DISPLAY ALL ROOMS
                Text("All \(building) Rooms").font(.title2).bold()
                SearchBarView(text: $text, globalModel: globalModel)
            }
            .padding(.horizontal)
            List {
                ForEach(100 ..< 360) { room in
                    let openHour = 1 + 12 // 12 hour format.
                    let closeHour = 10 + 12 // 12 hour format.
                    let time = Int.random(in: openHour ... closeHour)
                    let hour12Format = time - 12

                    HStack(alignment: .center) {
                        Text("Room \(room)").bold().frame(width: 100, alignment: .leading)
                        Spacer()
                        Text("Open Until \(hour12Format)PM")
                            .font(.caption)
                        Spacer()
                        Image(systemName: isRoomClosedIcon(hour: time))
                            .foregroundColor(isRoomClosedStatus(hour: time))
                    } //: HSTACK
                } //: LOOP
            } //: LIST
            .listStyle(InsetGroupedListStyle())
        } //: VSTACK
        .edgesIgnoringSafeArea(.bottom)
    }
}

func isClosed(hour: Int) -> Bool {
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
