//
//  PolyLine_Demo.swift
//  MapKit Demo
//
//  Created by Hamed Kharazmi on 20.01.26.
//

import SwiftUI
import MapKit

struct PolyLine_Demo: View {
    let simpleStrokeStyle = StrokeStyle(
        lineWidth: 2.5,
        lineCap: .round,
        lineJoin: .round,
        dash: [5, 5]
    )
    let boldDashedStyle = StrokeStyle(
        lineWidth: 4,
        lineCap: .butt,
        lineJoin: .miter,
        dash: [10, 4]
    )
    let subtleDotStyle = StrokeStyle(
        lineWidth: 1.5,
        lineCap: .round,
        lineJoin: .round,
        dash: [2, 6]
    )
    let wavyDashStyle = StrokeStyle(
        lineWidth: 3,
        lineCap: .round,
        lineJoin: .round,
        dash: [8, 3, 4, 3]
    )
    let doubleLineStyle = StrokeStyle(
        lineWidth: 5,
        lineCap: .butt,
        lineJoin: .miter,
        dash: [12, 6]
    )
    var strokeStyles: [(name: String, style: StrokeStyle)] {
        [
            ("Simple Dash", simpleStrokeStyle),
            ("Bold Dash", boldDashedStyle),
            ("Subtle Dot", subtleDotStyle),
            ("Wavy Dash", wavyDashStyle),
            ("Double Line", doubleLineStyle)
        ]
    }
    @State private var strokeIndex = 0
    var style: StrokeStyle {
        strokeStyles[strokeIndex % strokeStyles.count].style
    }
    let gradient = Gradient(colors: [.red, .green, .blue])
    
    var currentStyleName: String {
        strokeStyles[strokeIndex % strokeStyles.count].name
    }
    
    let colorList: [Color] = [
        .red,
        .blue,
        .green,
        .orange,
        .purple
    ]
    @State private var colorIndex = 0
    var color: Color {
        colorList[colorIndex % strokeStyles.count]
    }
    var locIndice: [(Int, Locations)] {
        Array(
            zip(
                Locations.locationsInSpain.indices,
                Locations.locationsInSpain
            )
        )
    }
    
    var body: some View {
        ZStack {
            Map {
                ForEach(locIndice, id: \.0) { i, location in
                    Marker(
                        location.name,
                        coordinate: location.coordinate
                    )
                    .tint(colorList[i % colorList.count])
                }
                
                MapPolyline(coordinates: Locations.locationsInSpain.coordinates)
                    .stroke(gradient, style: style)
            }
            Title
        }.onTapGesture {
            strokeIndex += 1
            colorIndex += 1
        }
    }
    
    private var Title: some View {
        Text("Current Style: \(currentStyleName)")
            .padding()
            .background(Color.black.opacity(0.5).gradient)
            .foregroundStyle(.white)
            .bold()
            .clipShape(.rect(cornerRadius: 8))
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    PolyLine_Demo()
}
