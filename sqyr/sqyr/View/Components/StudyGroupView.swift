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
                SearchBarView(text: $text, model: globalModel)

                // DISPLAY ALL ROOMS
                Text("All \(building) Rooms").font(.title2).bold()
                SearchBarView(text: $text, model: globalModel)
            }
            .padding(.horizontal)
            List {
                ForEach(100..<361) { room in
                    let openHour = 8
                    let closeHour = 10 + 12 // represents 10 PM.
                    let randomHour = Int.random(in: openHour ... closeHour)

                    HStack(alignment: .center) {
                        Text("Room \(room)").bold().frame(width: 100, alignment: .leading)
                        Spacer()
                        if roomIsClosed(closedHour: randomHour) {
                            roomIsCloseView(openHour: openHour)
                        } else {
                            roomIsOpenView(closeHour: closeHour)
                        }
                    } //: HSTACK
                } //: LOOP
            } //: LIST
            .listStyle(InsetGroupedListStyle())
        } //: VSTACK
        .edgesIgnoringSafeArea(.bottom)
    }
}

func roomIsClosed(closedHour: Int) -> Bool {
    let currentHour = Calendar.current.component(.hour, from: Date())

    return currentHour < 8 && currentHour < closedHour
}
    
struct roomIsOpenView: View {
    let closeHour: Int
    
    var body: some View {
        roomRowView(text: "Open until \(closeHour - 12) PM", iconImage: "circlebadge.fill", iconColor: Color.green)
    }
}

struct roomIsCloseView: View {
    let openHour: Int
    
    var body: some View {
        roomRowView(text: "Closed until \(openHour) AM", iconImage: "lock.circle.fill", iconColor: Color.red)
    }
}

struct roomRowView: View {
    let text: String
    let iconImage: String
    let iconColor: Color
    
    var body: some View {
        Text(text)
            .font(.caption)
        Spacer()
        Image(systemName: iconImage)
            .foregroundColor(iconColor)
    }
}

struct StudyGroupView_Previews: PreviewProvider {
    static var previews: some View {
        StudyGroupView(building: "TEGR", globalModel: GlobalModel())
    }
}
