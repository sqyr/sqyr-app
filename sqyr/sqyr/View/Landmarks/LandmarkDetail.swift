//
//  BuildingPopUpView.swift
//  sqyr
//
//  Created by Steven Phun on 2/10/21.
//

import SwiftUI

struct LandmarkDetail: View {
    var landmark: Landmark
    @State var isShowingCredits: Bool = false

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            // LANDMARK BANNER IMAGE
            LandmarkBannerImage(landmark: landmark)

            // LANDMARK HOURS TITLE
            LandmarkTitleView(icon: landmark.icon ?? "", title: landmark.landMarkName ?? "")

            // LANDMARK HOURS CONTENT
            LandmarkHoursView(with: landmark)

            // LANDMARK INFORMATION CONTENT
            LandmarkTitleView(icon: "info.circle.fill", title: "About")

            // LANDMARK ABOUT
            GroupBox {
                Text(landmark.description ?? "")
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: 315)
            }

            // OPTIONAL ACTION TITLE
            if (landmark.classRoomsId != nil && landmark.classRoomsId!.count > 0) || (landmark.floorPlanImage != nil && landmark.floorPlanImage!.level1 != "null") {
                LandmarkTitleView(icon: "ellipsis.circle.fill", title: "Actions")
            }

            // OPTIONAL ACTION CONTENT
            HStack {
                // STUDY GROUP BUTTON
                if landmark.classRoomsId != nil && landmark.classRoomsId!.count > 0 {
                    Spacer()
                    NavigationLink(destination: StudyGroupView(landmark: landmark, globalModel: GlobalModel())) {
                        Text("Study Groups")
                            .padding()
                    }
                    .buttonStyle(SolidButtonStyle(backgroundColor: Color("blue"), foregroundColor: .white))
                }

                // FLOOR PLAN BUTTON
                if landmark.floorPlanImage != nil && landmark.floorPlanImage!.level1! != "null" {
                    Spacer()
                    NavigationLink(destination: LocateClassroomView(landmark: landmark)) {
                        Text("Find My Classroom")
                            .padding()
                    }
                    .buttonStyle(SolidButtonStyle(backgroundColor: Color("blue"), foregroundColor: .white))
                    Spacer()
                }
            }
            .frame(maxWidth: 340)
            .padding(.bottom)
        } //: SCROLLVIEW
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
        .edgesIgnoringSafeArea(.all)
        .padding(.bottom)
        .onAppear {
            hapticFeedback.impactOccurred()
        }
    }
}

struct LandmarkBannerImage: View {
    let landmark: Landmark
    @State private var showHeadline: Bool = false

    // MARK: - FUNCTIONS

    func slideInAnimation() -> Animation {
        Animation.spring(response: 1.5, dampingFraction: 0.5, blendDuration: 0.5)
            .speed(1)
            .delay(0.25)
    }

    var body: some View {
        ZStack {
            // MARK: - IMAGE

            Image(landmark.images ?? "")
                .resizable()
                .scaledToFit()
            HStack(alignment: .top, spacing: 0) {
                Rectangle()
                    .fill(Color("gold"))
                    .frame(width: 4)

                VStack(alignment: .leading, spacing: 6) {
                    // MARK: - HEADLINE

                    Text(landmark.landMarkName ?? "")
                        .font(.system(.title, design: .serif))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .shadow(radius: 3)

                    // MARK: - SUBHEADLINE

                    Text(landmark.description ?? "")
                        .font(.footnote)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.white)
                        .shadow(radius: 3)
                } //: VSTACK
                .padding(.vertical, 0)
                .padding(.horizontal, 20)
                .frame(width: 281, height: 105)
                .background(Color("ColorBlackTransparent"))
            } //: HSTACK
            .frame(width: 285, height: 105, alignment: .center)
            .offset(x: -40, y: showHeadline ? 95 : 65)
            .animation(slideInAnimation())
            .onAppear {
                self.showHeadline.toggle()
            }
        } //: ZSTACK
        .frame(width: 480, height: 320, alignment: .center)
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

struct LandmarkHoursView: View {
    let landmark: Landmark

    var hours: [Int: String]

    init(with landmark: Landmark) {
        self.landmark = landmark

        hours = [Int: String]()
        if let landmarkHours = landmark.hours {
            hours[0] = landmarkHours.mon ?? "CLOSED"
            hours[1] = landmarkHours.tue ?? "CLOSED"
            hours[2] = landmarkHours.wed ?? "CLOSED"
            hours[3] = landmarkHours.thu ?? "CLOSED"
            hours[4] = landmarkHours.fri ?? "CLOSED"
            hours[5] = landmarkHours.sat ?? "CLOSED"
            hours[6] = landmarkHours.sun ?? "CLOSED"
            for hour in hours {
                if hour.value == "null" {
                    hours[hour.key] = "Closed"
                }
            }
        }
    }

    var body: some View {
        GroupBox {
            Group {
                HStack {
                    Image(systemName: "clock")
                    Text("Hours of Operation")
                        .fontWeight(.bold)
                } //: HSTACK
                VStack {
                    LazyVGrid(columns: getGridLayout(), spacing: 6) {
                        ForEach(0 ..< hours.count) { n in
                            Text(getDayString(forWeekDay: n))
                                .fontWeight(.bold)
                            Text(hours[n] ?? "NO HOURS")
                        }
                    } //: GRID
                } //: VSTACK
            }
        } //: BOX
        .foregroundColor(.secondary)
        .frame(maxWidth: 360)
    }

    func getGridLayout() -> [GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: 2), count: 2)
    }

    func getDayString(forWeekDay weekDay: Int) -> String {
        switch weekDay {
        case 0:
            return "Monday"
        case 1:
            return "Tuesday"
        case 2:
            return "Wednesday"
        case 3:
            return "Thursday"
        case 4:
            return "Friday"
        case 5:
            return "Saturday"
        case 6:
            return "Sunday"
        default:
            return ""
        }
    }
}

// TODO: Fix preview
// struct BuildingPopUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        LandmarkDetail(landmark: landmarks[0])
//    }
// }
