//
//  ConnectedAlert.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/23/25.
//

import SwiftUI

struct ConnectedAlert: View {
    let onConfirm: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("iPhone 연결 완료!")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.green)
            
            Text("동화를 시작하시겠습니까?")
                .font(.body)
            
            HStack(spacing: 20) {
                Button("취소") { onCancel() }
                    .buttonStyle(.bordered)
                
                Button("확인") { onConfirm() }
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
    ConnectedAlert(onConfirm: { }, onCancel: { })
}
