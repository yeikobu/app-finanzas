//
//  GoalRowView.swift
//  app-finanzas
//
//  Created by Jacob Aguilar on 13-01-25.
//

import SwiftUI

struct GoalRowView: View {
    
    var financeGoal: FinanceGoalModel
    
    var body: some View {
        NavigationLink(value: financeGoal) {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(financeGoal.name)
                            .bold()
                        
                        HStack(spacing: 4) {
                            Text("\(financeGoal.alreadySaved ?? 0, specifier: "%.2f")")
                            
                            Text("/")
                            
                            Text("\(financeGoal.totalToSave, specifier: "%.2f")")
                                .foregroundStyle(.primary)
                                .bold()
                        }
                        .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                    
                    
                }
            }
        }
    }
}

#Preview {
    GoalRowView(financeGoal: .init(name: "Vacaciones en Brasil", totalToSave: 2000, alreadySaved: 100))
}
