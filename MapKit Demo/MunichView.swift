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
    
    @State private var currentOffset: CGSize = .zero
    @State private var endOffset: CGSize = .zero
    
    var offset: CGSize {
        CGSize(
            width: currentOffset.width + endOffset.width,
            height: currentOffset.height + endOffset.height
        )
    }
    @State private var isPinned: Bool = false
    
    let lower = 0.05
    let upper = 0.3
    
    var body: some View {
        VStack {
            Text("Adjust Zoom Level")
                .font(.subheadline)
                .padding(.bottom, 5)
            
            Slider(
                value: $delta,
                in: lower...upper,
                label: { Text("Munich Landmark") }) {
                    Text("\(lower.formatted())")
                        .foregroundStyle(.secondary)
                } maximumValueLabel: {
                    Text("\(upper.formatted())")
                        .foregroundStyle(.secondary)
                }
                .tint(.purple)
                .padding(.horizontal)
            
            HStack {
                Text("Close-up")
                Spacer()
                Text("Wide View")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            
            // Pin button
            Button {
                isPinned.toggle()
                withAnimation {
                    endOffset = .zero
                    currentOffset = .zero
                }
            } label: {
                Label(
                    "Pin",
                    systemImage: isPinned ? "pin.fill" : "pin"
                )
                .font(.caption)
                .foregroundStyle(isPinned ? .blue : .secondary)
                .padding(5)
                .padding(.top, 5)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(.rect(cornerRadius: 12))
        .shadow(radius: 10)
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        .offset(offset)
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
