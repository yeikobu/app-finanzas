//
//  NewContributionView.swift
//  app-finanzas
//
//  Created by Jacob Aguilar on 14-01-25.
//

import SwiftUI

struct NewContributionView: View {
    
    @Environment(FinanceGoalsViewModel.self) private var financeGoalsViewModel
    @Environment(\.dismiss) private var dismiss
    
    @Binding var financeGoal: FinanceGoalModel
    @State private var amountToContribute: String = ""
    @State private var contributionDate: Date = .now
    @State private var showAddButton: Bool = false
    @State private var showErrorMessaje: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack(spacing: 40) {
                        Text("Monto a agregar")
                        
                        TextField("0", text: $amountToContribute)
                            .onChange(of: amountToContribute) {
                                if !amountToContribute.isEmpty {
                                    if let amountToAdd = Double(amountToContribute) {
                                        if amountToAdd > 0 {
                                            withAnimation(.bouncy) {
                                                showAddButton = true
                                            }
                                        } else {
                                            withAnimation(.easeOut) {
                                                showAddButton = false
                                            }
                                        }
                                    }
                                } else {
                                    withAnimation(.easeOut) {
                                        showAddButton = false
                                    }
                                }
                            }
                    }
                    
                    HStack(spacing: 40) {
                        DatePicker("Fecha límite", selection: $contributionDate)
                            .padding(.vertical, 1)
                    }
                }
                .alert("Error al agregar aporte", isPresented: $showErrorMessaje) {
                    Button("Aceptar", role: .cancel) {}
                } message: {
                    Text("El aporte debe ser mayor a cero")
                }
            }
            .navigationTitle("Nuevo aporte")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    CustomPrimaryButtonView(text: "Agregar") {
                        if let amountToAdd = Double(amountToContribute) {
                            if amountToAdd > 0 {
                                let goalToAdd = ContributionModel(date: contributionDate, amount: amountToAdd)
                                financeGoal.contributions.append(goalToAdd)
                                
                                financeGoal.alreadySaved = financeGoalsViewModel.getTotalSaved(contributions: financeGoal.contributions)
                                
                                // A través del environment, actualiza el aporte hasta el padre
                                financeGoalsViewModel.addContribution(contribution: goalToAdd)
                                
                                dismiss()
                            } else {
                                showErrorMessaje.toggle()
                            }
                        } else {
                            showErrorMessaje.toggle()
                        }
                    }
                    .scaleEffect(showAddButton ? 1 : 0)
                    .disabled(!showAddButton)
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var financeGoalsViewModel = FinanceGoalsViewModel()
    
    NewContributionView(financeGoal: .constant(FinanceGoalModel(name: "Macbook pro", totalToSave: 2000, alreadySaved: 300)))
        .environment(financeGoalsViewModel)
}
