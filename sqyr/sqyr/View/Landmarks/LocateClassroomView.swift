//
//  LocateClassroomView.swift
//  sqyr
//
//  Created by Steven Phun on 3/1/21.
//

import SwiftUI

struct LocateClassroomView: View {
    let landmark: Landmark
    var floorNames = [String]()
    var floorImageNames = [String]()
    @State var selected: Int = 0
    @State var scale: CGFloat = 1.0
    @State var isTapped: Bool = false
    @State var tapLocation: CGPoint = CGPoint.zero
    @State var dragSize: CGSize = CGSize.zero
    @State var dragPrevious: CGSize = CGSize.zero
    @State var reset: Bool = true
    
    init(landmark: Landmark) {
        self.landmark = landmark
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color("gold"))], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.white)], for: .normal)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("gold"))]
        
        // This is literally the only way I could think to get a collection of both the floor names AND the floor image names. -David
        if let basement = landmark.floorPlanImage?.basement, basement != "null" {
            floorNames.append("Basement")
            floorImageNames.append(basement)
        }
        if let level1 = landmark.floorPlanImage?.level1, level1 != "null" {
            floorNames.append("Level 1")
            floorImageNames.append(level1)
        }
        if let level2 = landmark.floorPlanImage?.level2, level2 != "null" {
            floorNames.append("Level 2")
            floorImageNames.append(level2)
        }
        if let level3 = landmark.floorPlanImage?.level3, level3 != "null" {
            floorNames.append("Level 3")
            floorImageNames.append(level3)
        }
        if let level4 = landmark.floorPlanImage?.level4, level4 != "null" {
            floorNames.append("Level 4")
            floorImageNames.append(level4)
        }
    }
    
    var body: some View {
        GeometryReader { reader in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        Picker(selection: $selected, label: Text("Select Any Level")) {
                            ForEach(floorNames, id: \.self) { floor in
                                Text(floor).tag(self.floorNames.firstIndex(of: floor)!)
                            }
                        } //: PICKER
                        .pickerStyle(SegmentedPickerStyle())
                        .background(Color("blue"))
                        .cornerRadius(8)
                        .padding()
                    } //: HSTACK
                    
                    Text(floorNames[selected])
                        .fontWeight(.bold)
                        .padding()
                    
                    Image(floorImageNames[selected])
                        .resizable()
                        .scaledToFit()
                        .animation(.default)
                        .offset(x: self.reset ? 0 : self.dragSize.width, y: self.reset ? 0 : self.dragSize.height)
                        .scaleEffect(self.scale)
                        .scaleEffect(1,
                                     anchor: UnitPoint(
                                        x: self.tapLocation.x / reader.frame(in: .global).maxX,
                                        y: self.tapLocation.y / reader.frame(in: .global).maxY
                                     ))
                        .gesture(TapGesture(count: 1)
                                    .onEnded({
                                        self.scale = 1.0
                                    })
                                    .simultaneously(with: DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                                        .onChanged({ (value) in
                                                            self.reset = false
                                                            self.tapLocation = value.startLocation
                                                            self.dragSize = CGSize(
                                                                width: value.translation.width + self.dragPrevious.width,
                                                                height: value.translation.height + self.dragPrevious.height)
                                                        }).onEnded({ (value) in
                                                            let globalMaxX = reader.frame(in: .global).maxX
                                                            let offsetWidth = ((globalMaxX * self.scale) - globalMaxX) / 2
                                                            let newDraggedWidth = self.dragSize.width * self.scale
                                                            if (newDraggedWidth > offsetWidth) {
                                                                self.dragSize = CGSize(
                                                                    width: offsetWidth / self.scale,
                                                                    height: value.translation.height + self.dragPrevious.height
                                                                )
                                                            } else if (newDraggedWidth < -offsetWidth) {
                                                                self.dragSize = CGSize(
                                                                    width: -offsetWidth / self.scale,
                                                                    height: value.translation.height + self.dragPrevious.height
                                                                )
                                                            } else {
                                                                self.dragSize = CGSize(
                                                                    width: value.translation.width + self.dragPrevious.width,
                                                                    height: value.translation.height + self.dragPrevious.height
                                                                )
                                                            }
                                                            //self.previousDragged = self.draggedSize
                                                            self.reset = true
                                                        }))).gesture(MagnificationGesture()
                                                                        .onChanged({ (scale) in
                                                                            self.scale = scale.magnitude
                                                                        }).onEnded({ (scaleFinal) in
                                                                            self.scale = scaleFinal.magnitude
                                                                        }))
                } //: VSTACK
            } //: SCROLL
        } //: GEOMETRY
        .navigationBarTitle("\(landmark.landMarkName!) Floor Plan", displayMode: .inline)
    }
}

// TODO: Fix preview
//struct LocateClassroomView_Previews: PreviewProvider {
//    static var previews: some View {
//        LocateClassroomView(landmark: landmarks[0])
//    }
//}
