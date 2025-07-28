//
//  iPadAirPlayView.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/28/25.
//

import AVKit
import SwiftUI

struct iPadAirPlayButtonView: UIViewRepresentable {
    func makeUIView(context: Context) -> AVRoutePickerView {
        let routePickerView = AVRoutePickerView()
        routePickerView.activeTintColor = .blue
        routePickerView.tintColor = .gray
        routePickerView.prioritizesVideoDevices = false
        return routePickerView
    }

    func updateUIView(_ uiView: AVRoutePickerView, context: Context) { }
}
