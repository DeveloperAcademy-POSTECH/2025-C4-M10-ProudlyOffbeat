//
//  NonconnectionAlert.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/23/25.
//

import SwiftUI

struct NonconnectionAlert: View {
    let onConfirm: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("동화를 진행할 수 없습니다.")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.red)
            
            Text("하나의 기기와 연결을 완료해주세요.")
                .multilineTextAlignment(.center)
            
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
    NonconnectionAlert( onConfirm: {}, onCancel: {} )
}
