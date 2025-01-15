//
//  FeedbackPillView.swift
//  app-finanzas
//
//  Created by Jacob Aguilar on 14-01-25.
//

import SwiftUI

struct FeedbackPillView: View {
    
    @Binding var showMessage: Bool
    var systemImageName: String
    var feedbackMessage: String
    
    var body: some View {
        HStack {
            Image(systemName: systemImageName)
                .foregroundStyle(.green)
            
            Text(feedbackMessage)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.ultraThinMaterial)
        )
        .shadow(radius: 5)
    }
}

#Preview {
    FeedbackPillView(showMessage: .constant(true), systemImageName: "checkmark.circle.fill", feedbackMessage: "Meta eliminada")
}
