//
//  DisconnectedAlert.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/23/25.
//

import SwiftUI

struct DisconnectedAlert: View {
    let onReconnect: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("연결이 끊어졌습니다")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.red)
            
            Text("동화 연결이 끊어졌습니다.\n재연결하시겠습니까?")
                .multilineTextAlignment(.center)
            
            HStack(spacing: 20) {
                Button("취소") { onCancel() }
                    .buttonStyle(.bordered)
                
                Button("재연결") { onReconnect() }
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding(24)
        .frame(maxWidth:300)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 12, x: 0, y: 6)
    }
}

#Preview {
    DisconnectedAlert( onReconnect: {}, onCancel: {} )
}
