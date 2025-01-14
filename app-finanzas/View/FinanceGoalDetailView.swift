//
//  FinanceGoalDetailView.swift
//  app-finanzas
//
//  Created by Jacob Aguilar on 13-01-25.
//

import SwiftUI

struct FinanceGoalDetailView: View {
    
    @State var financeGoal: FinanceGoalModel
    
    var body: some View {
        List {
            Section {
                HStack(spacing: 40) {
                    Text("Nombre meta")
                    
                    Text(financeGoal.name)
                }
                
                HStack(spacing: 40) {
                    Text("Total a ahorrar")
                    
                    
                    Text("\(financeGoal.totalToSave, specifier: "%.2f")")
                }
                
                HStack(spacing: 40) {
                    Text("Total ahorrado")
                    
                    Text("\(financeGoal.alreadySaved ?? 0, specifier: "%.2f")")
                }
                
                HStack(spacing: 40) {
                    Text("Fecha de creación")
                    
                    Text(formatDate(date: financeGoal.createdAt))
                }
            } header: {
                Text("Información de la mete")
            }
            
            // If the goal has contributions, shows them
            if !financeGoal.contributions.isEmpty {
                List {
                    ForEach(financeGoal.contributions, id: \.id) { contribution in
                        HStack {
                            Text("\(contribution.amount, specifier: "%.2f")")
                            
                            Text(formatDate(date: contribution.date))
                        }
                    }
                }
            }
        }
        .navigationTitle(financeGoal.name)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                CustomPrimaryButtonView(text: "Agregar Monto") {
                    
                }
            }
        }
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.setLocalizedDateFormatFromTemplate("YYYMMMdhhmm")
        return formatter.string(from: date)
    }
}

#Preview {
    FinanceGoalDetailView(financeGoal: .init(name: "Macbook Pro", totalToSave: 300, alreadySaved: 2000))
}
