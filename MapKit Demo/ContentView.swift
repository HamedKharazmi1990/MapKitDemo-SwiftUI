//
//  ContentView.swift
//  MapKit Demo
//
//  Created by Hamed Kharazmi on 20.01.26.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        Map {
            ForEach(locationsInSpain) { location in
                Marker(
                    location.name,
                    coordinate: location.coordinate
                )
                .tint(.blue)
            }
        }
    }
}

#Preview {
    ContentView()
}
