//
//  FromiPadConnectedAlert.swift
//  LivingStory-iOS
//
//  Created by Demian Yoo on 7/24/25.
//

import SwiftUI

struct FromiPadConnectedAlert: View {
    let connectedDeviceName: String
    let onConfirm: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("iPad와의 연결 완료")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.green)
            
            Text("\(connectedDeviceName)와 연결되었습니다.\n이제 iPad에서 사용할 수 있어요.")
                .font(.body)
                .multilineTextAlignment(.center)
            
            Button("확인") {
                onConfirm()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(24)
        .frame(maxWidth: 300)
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 12, x: 0, y: 6)
    }
}

#Preview {
    FromiPadConnectedAlert(
        connectedDeviceName: "iPad Pro",
        onConfirm: { }
    )
}
