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
    var strokeStyles: [StrokeStyle] {
        [
            simpleStrokeStyle,
            boldDashedStyle,
            subtleDotStyle,
            wavyDashStyle,
            doubleLineStyle
        ]
    }
    @State private var strokeIndex = 0
    var style: StrokeStyle {
        strokeStyles[strokeIndex % strokeStyles.count]
    }
    let gradient = Gradient(colors: [.red, .green, .blue])
    var body: some View {
        Map {
            ForEach(Locations.locationsInSpain) { location in
                Marker(
                    location.name,
                    coordinate: location.coordinate
                )
                .tint(.blue)
            }
            
            MapPolyline(coordinates: Locations.locationsInSpain.coordinates)
            .stroke(gradient, style: style)
        }
        .onTapGesture {
            strokeIndex += 1
        }
    }
}

#Preview {
    PolyLine_Demo()
}
