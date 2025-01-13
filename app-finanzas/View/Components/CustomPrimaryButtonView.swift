//
//  CustomPrimaryButtonView.swift
//  Metas Financieras
//
//  Created by Jacob on 12-01-25.
//

import SwiftUI

struct CustomPrimaryButtonView: View {
    
    var text: String
    var action: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .foregroundStyle(colorScheme == .dark ? .black : .white)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .fontWeight(.medium)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                }
        }
    }
}

#Preview {
    CustomPrimaryButtonView(text: "Nombre botón", action: {})
}
