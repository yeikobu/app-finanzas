//
//  NewGoalView.swift
//  Metas Financieras
//
//  Created by Jacob on 12-01-25.
//

import SwiftUI

struct NewGoalView: View {
    //EnvironmentObject
    @Environment(FinanceGoalsViewModel.self) private var financeGoalsViewModel
    
    @State private var newGoalViewModel: NewGoalViewModel = .init()
    
    @State private var goalName: String = ""
    @State private var totalToSave: String = ""
    @State private var alreadySaved: String = ""
    @State private var isDeadlineNeeded: Bool = false
    @State private var deadline: Date = .now
    
    @State private var areFieldsCompleted: Bool = false
    @State private var isTotalToSaveGraterThanZero: Bool = false
    @State private var isTotalAlreadySavedGreaterThanZero: Bool = false
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Text("Nombre meta")
                        
                        VStack {
                            TextField("Ej: Vacaciones en Brasil", text: $goalName)
                                .onChange(of: goalName) {
                                    withAnimation(.bouncy) {
                                        areFieldsCompleted = newGoalViewModel.checkRequieredFieldsAreNotEmpty(goalName: goalName, totalToSave: totalToSave)
                                    }
                                }
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Total a ahorrar")
                            
                            TextField("0", text: $totalToSave)
                                .keyboardType(.numbersAndPunctuation)
                                .onChange(of: totalToSave) {
                                    withAnimation(.bouncy) {
                                        areFieldsCompleted = newGoalViewModel.checkRequieredFieldsAreNotEmpty(goalName: goalName, totalToSave: totalToSave)
                                    }
                                    
                                    withAnimation {
                                        isTotalToSaveGraterThanZero = newGoalViewModel.checkFieldGreaterThanZero(field: totalToSave)
                                    }
                                }
                        }
                        
                        if !isTotalToSaveGraterThanZero && !totalToSave.isEmpty {
                            HStack(spacing: 4) {
                                Image(systemName: "exclamationmark.triangle")
                                    .symbolEffect(.wiggle.byLayer, options: .nonRepeating)
                                    .bold()
                                
                                Text("El total a ahorrar debe ser mayor a 0")
                            }
                            .foregroundStyle(.red.opacity(0.6))
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Total ahorrado")
                            
                            TextField("0", text: $alreadySaved)
                                .keyboardType(.numbersAndPunctuation)
                                .onChange(of: alreadySaved) {
                                    isTotalAlreadySavedGreaterThanZero = newGoalViewModel.checkFieldGreaterThanZero(field: alreadySaved)
                                }
                        }
                        
                        if !isTotalToSaveGraterThanZero && !alreadySaved.isEmpty {
                            HStack(spacing: 4) {
                                Image(systemName: "exclamationmark.triangle")
                                    .symbolEffect(.wiggle.byLayer, options: .nonRepeating)
                                    .bold()
                                
                                Text("El total ahorrado debe ser mayor a 0")
                            }
                            .foregroundStyle(.red.opacity(0.6))
                        }
                    }
                    
                    VStack {
                        Toggle("Agregar fecha límite", isOn: $isDeadlineNeeded)
                            .tint(.primary)
                        
                        if isDeadlineNeeded {
                            DatePicker("Fecha límite", selection: $deadline)
                        }
                    }
                }
            }
            .navigationTitle("Nueva meta")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    CustomPrimaryButtonView(text: "Guardar meta") {
                        let newGoal = FinanceGoalModel(name: goalName, totalToSave: Double(totalToSave) ?? 0, alreadySaved: Double(alreadySaved) ?? 0, deadline: deadline)
                        
                        financeGoalsViewModel.addFinanceGoal(financeGoal: newGoal)
                        
                        dismiss()
                    }
                    .disabled(!areFieldsCompleted)
                    .scaleEffect(areFieldsCompleted && isTotalToSaveGraterThanZero ? 1 : 0)
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var financeGoalsViewModel = FinanceGoalsViewModel()
    NewGoalView()
        .environment(financeGoalsViewModel)
}
