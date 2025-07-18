//
//  HomeBackgroundView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/17/25.
//
import SwiftUI

struct HomeBackgroundView:View{
    var body: some View{
        Image("HomeBackground")
            .resizable()
            .scaledToFill()
            .frame(height: UIScreen.main.bounds.height)
            .ignoresSafeArea()
    }
}
