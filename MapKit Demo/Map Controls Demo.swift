//
//  Map Controls Demo.swift
//  MapKit Demo
//
//  Created by Hamed Kharazmi on 21.01.26.
//

import SwiftUI
import MapKit

struct Map_Controls_Demo: View {
    let englishGarten: CLLocationCoordinate2D = .englishGarten
    
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
    private let initialPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var body: some View {
        VStack {
            Map (position: $position) {
                Marker("English Garten", coordinate: .englishGarten)
            }
            .mapControls {
                MapScaleView()
                
                MapCompass()
                
                MapPitchToggle()
            }
            Button("Reset Map Position") {
                withAnimation {
                    position = initialPosition
                }
            }.buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    Map_Controls_Demo()
}
