//
//  Map Style Demo.swift
//  MapKit Demo
//
//  Created by Hamed Kharazmi on 21.01.26.
//

import SwiftUI
import MapKit

struct Map_Style_Demo: View {
    let center: CLLocationCoordinate2D
    
    @State private var mapStyle: MapStyle = .standard
    
    let span = MKCoordinateSpan(
        latitudeDelta: 0.15,
        longitudeDelta: 0.15
    )
    var region: MKCoordinateRegion {
        MKCoordinateRegion(center: center, span: span)
    }
    @State private var position: MapCameraPosition = MapCameraPosition.automatic
    var body: some View {
        ZStack {
            Map(position: $position)
                .mapStyle(mapStyle)
                .onAppear {
                    position = .region(region)
                }
            
            VStack {
                Spacer()
                
                HStack {
                    Button {
                        mapStyle = .standard
                    } label: {
                        Text("Standard")
                            .padding()
                            .clipShape(.rect(cornerRadius: 8))
                    }
                    Button {
                        mapStyle = .hybrid
                    } label: {
                        Text("Hybrid")
                            .padding()
                            .clipShape(.rect(cornerRadius: 8))
                    }
                    Button {
                        mapStyle = .imagery
                    } label: {
                        Text("Imagery")
                            .padding()
                            .clipShape(.rect(cornerRadius: 8))
                    }
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(.pink)
                .padding()
            }
        }
    }
}

#Preview {
    Map_Style_Demo(center: .munich)
}
