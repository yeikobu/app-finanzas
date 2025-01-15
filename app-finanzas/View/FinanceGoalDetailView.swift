//
//  FinanceGoalDetailView.swift
//  app-finanzas
//
//  Created by Jacob Aguilar on 13-01-25.
//

import SwiftUI

struct FinanceGoalDetailView: View {
    
    @State var financeGoal: FinanceGoalModel
    @State private var showNewContributionSheet: Bool = false
    @State private var showContributionAddedMessage: Bool = false
    @State private var showPill: Bool = false
    
    var body: some View {
        List {
            Section {
                HStack(spacing: 40) {
                    Text("Nombre meta")
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    Text(financeGoal.name)
                }
                
                HStack(spacing: 40) {
                    Text("Total a ahorrar")
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    Text("\(financeGoal.totalToSave, specifier: "%.2f")")
                }
                
                HStack(spacing: 40) {
                    Text("Total ahorrado")
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    Text("\(financeGoal.alreadySaved ?? 0, specifier: "%.2f")")
                }
                
                HStack(spacing: 40) {
                    Text("Fecha creación")
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                    
                    Text(formatDate(date: financeGoal.createdAt))
                        .multilineTextAlignment(.trailing)
                }
            } header: {
                Text("Información de la mete")
            }
            
            // If the goal has contributions, shows them
            if !financeGoal.contributions.isEmpty {
                Section {
                    ForEach(financeGoal.contributions.sorted(by: { $0.date > $1.date }), id: \.id) { contribution in
                        HStack {
                            Text("\(contribution.amount, specifier: "%.2f")")
                            
                            Spacer()
                            
                            Text(formatDate(date: contribution.date))
                        }
                    }
                } header: {
                    Text("Tus aportes")
                }
            }
        }
        .navigationTitle(financeGoal.name)
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                CustomPrimaryButtonView(text: "Agregar Monto") {
                    showNewContributionSheet.toggle()
                }
            }
        }
        .sheet(isPresented: $showNewContributionSheet) {
            NewContributionView(financeGoal: $financeGoal)
                .presentationDetents([.medium])
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
