//
//  MainView.swift
//  MapKit Demo
//
//  Created by Hamed Kharazmi on 21.01.26.
//

import SwiftUI

enum Titles: String, CaseIterable, Identifiable {
    case markerDemoView = "MarkerDemoView"
    case polylineDemo = "PolylineDemo"
    case munichView = "MunichView"
    case mapControlsDemo = "MapControlsDemo"
    case mapStyleDemo = "MapStyleDemo"
    case myLookAroundView = "MyLookAroundView"
    
    var id: String { rawValue }
    
    var displayName: String { rawValue }
    
    @ViewBuilder
        var destination: some View {
            switch self {
            case .markerDemoView:
                MarkerDemoView()
            case .polylineDemo:
                PolyLine_Demo()
            case .munichView:
                MunichView()
            case .mapControlsDemo:
                Map_Controls_Demo()
            case .mapStyleDemo:
                Map_Style_Demo(center: .munich)
            case .myLookAroundView:
                MyLookAroundView(location: .munich, text: "Exploring Munich")
            }
        }
}

struct MainView: View {
    var body: some View {
        NavigationStack {
            List(Titles.allCases, id: \.self) { title in
                NavigationLink {
                    title.destination
                } label: {
                    Text(title.displayName)
                }
            }
            .navigationTitle("MapKit Demo")
        }
    }
}

#Preview {
    MainView()
}
