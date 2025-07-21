//
//  ControllNavigationButtonView.swift
//  LivingStory-iOS
//
//  Created by 문창재 on 7/21/25.
//
import SwiftUI

struct ControllNavigationButtonView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    let nextView:AppRoute
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Button{
                    coordinator.pop()
                }label: {
                    Image("PreviousButton")
                        .padding()
                }
                Spacer()
                Button{
                    coordinator.push(nextView)
                }label: {
                    Image("NextButton")
                        .padding()
                }
            }
        }
        
    }
}

