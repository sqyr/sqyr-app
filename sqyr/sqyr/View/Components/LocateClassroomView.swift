//
//  LocateClassroomView.swift
//  sqyr
//
//  Created by Steven Phun on 3/1/21.
//

import SwiftUI

struct LocateClassroomView: View {
    let building: String
    let levels = ["Level 1", "Level 2", "Level 3"]
    @State var selected = 0
    @State var scale: CGFloat = 1.0
    @State var isTapped: Bool = false
    @State var pointTapped: CGPoint = CGPoint.zero
    @State var draggedSize: CGSize = CGSize.zero
    @State var previousDragged: CGSize = CGSize.zero
    @State var reset: Bool = true
    
    init(building: String) {
        self.building = building
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color("gold"))], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.white)], for: .normal)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("gold"))]
    }
    
    var body: some View {
        GeometryReader { reader in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        Picker(selection: $selected, label: Text("Select Any Level")) {
                            ForEach(0..<levels.count) { index in
                                Text(levels[index]).tag(index)
                            }
                        } //: PICKER
                        .pickerStyle(SegmentedPickerStyle())
                        .background(Color("blue"))
                        .cornerRadius(8)
                        .padding()
                    } //: HSTACK
                    
                    Text("Level \(selected + 1)")
                        .fontWeight(.bold)
                        .padding()
                    
                    Image(floorPlanImage(building: building, floor: selected + 1))
                        .resizable()
                        .scaledToFit()
                        .animation(.default)
                        .offset(x: self.reset ? 0 : self.draggedSize.width, y: self.reset ? 0 : self.draggedSize.height)
                        .scaleEffect(self.scale)
                        .scaleEffect(1,
                                     anchor: UnitPoint(
                                        x: self.pointTapped.x / reader.frame(in: .global).maxX,
                                        y: self.pointTapped.y / reader.frame(in: .global).maxY
                                     ))
                        .gesture(TapGesture(count: 1)
                                    .onEnded({
                                        self.scale = 1.0
                                    })
                                    .simultaneously(with: DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                                        .onChanged({ (value) in
                                                            self.reset = false
                                                            self.pointTapped = value.startLocation
                                                            self.draggedSize = CGSize(
                                                                width: value.translation.width + self.previousDragged.width,
                                                                height: value.translation.height + self.previousDragged.height)
                                                        }).onEnded({ (value) in
                                                            let globalMaxX = reader.frame(in: .global).maxX
                                                            let offsetWidth = ((globalMaxX * self.scale) - globalMaxX) / 2
                                                            let newDraggedWidth = self.draggedSize.width * self.scale
                                                            if (newDraggedWidth > offsetWidth) {
                                                                self.draggedSize = CGSize(
                                                                    width: offsetWidth / self.scale,
                                                                    height: value.translation.height + self.previousDragged.height
                                                                )
                                                            } else if (newDraggedWidth < -offsetWidth) {
                                                                self.draggedSize = CGSize(
                                                                    width: -offsetWidth / self.scale,
                                                                    height: value.translation.height + self.previousDragged.height
                                                                )
                                                            } else {
                                                                self.draggedSize = CGSize(
                                                                    width: value.translation.width + self.previousDragged.width,
                                                                    height: value.translation.height + self.previousDragged.height
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
        .navigationBarTitle("\(building) Floor Plan", displayMode: .inline)
    }
}

struct LocateClassroomView_Previews: PreviewProvider {
    static var previews: some View {
        LocateClassroomView(building: "TEGR")
    }
}
