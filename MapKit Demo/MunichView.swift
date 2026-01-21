//
//  MunichView.swift
//  MapKit Demo
//
//  Created by Hamed Kharazmi on 21.01.26.
//

import SwiftUI
import MapKit

struct MunichView: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var delta: Double = 0.15
    @State private var offset: CGSize = .zero
    @State private var isPinned: Bool = false
    
    var span: MKCoordinateSpan {
        MKCoordinateSpan(
            latitudeDelta: delta,
            longitudeDelta: delta
        )
    }
    var munichRegion: MKCoordinateRegion {
        MKCoordinateRegion(
            center: .munich,
            span: span
        )
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(position: $cameraPosition) {
                
            }
            
            ControlsView(delta: $delta)
        }.onAppear {
            cameraPosition = .region(munichRegion)
        }
        .onChange(of: delta) { _, _ in
            cameraPosition = .region(munichRegion)
        }
    }
}

struct ZoomSliderView: View {
    @Binding var delta: Double
    
    var body: some View {
        Slider(value: $delta, in: 0.05...0.3)
            .padding()
    }
}

struct MunichTitleView: View {
    var body: some View {
        Text("Explore Munich")
            .font(.largeTitle)
            .bold()
            .padding()
            .foregroundStyle(
                LinearGradient(
                    colors: [.blue, .purple],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 12))
            .shadow(radius: 10)
    }
}

struct ControlsView: View {
    @Binding var delta: Double
    
    var body: some View {
        VStack {
            MunichTitleView()
            
            Spacer()
            
            ZoomSliderView(delta: $delta)
        }
    }
}

#Preview {
    MunichView()
}
