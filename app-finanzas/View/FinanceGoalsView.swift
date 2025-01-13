//
//  FinanceGoalsView.swift
//  Metas Financieras
//
//  Created by Jacob on 12-01-25.
//

import SwiftUI

struct FinanceGoalsView: View {
    
    //Environmets
    @State private var financeGoalsViewModel: FinanceGoalsViewModel = .init()
    
    // SearchBar text state
    @State private var goalTextToSearch: String = ""
    
    // Segmented Control State
    enum SegmentedControlOption: String, CaseIterable, Identifiable {
        case todas
        case sinCompletar = "Sin completar"
        case completadas
        var id: Self { self }
    }
    
    @State private var selectedOption: SegmentedControlOption = .todas
    
    // Show new goal sheet state
    @State private var showNewGoalSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if !financeGoalsViewModel.financeGoals.isEmpty {
                    Picker("", selection: $selectedOption) {
                        ForEach(SegmentedControlOption.allCases) { option in
                            Text(option.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 10)
                    
                    List {
                        ForEach(financeGoalsViewModel.financeGoals) { goal in
                            GoalRowView(financeGoal: goal)
                        }
                    }
                    .navigationDestination(for: FinanceGoalModel.self) { goal in
                        FinanceGoalDetailView(financeGoal: goal)
                    }
                    .searchable(text: $goalTextToSearch, prompt: "Buscar meta")
                } else {
                    VStack {
                        Label("No has registrado ninguna meta aún", systemImage: "exclamationmark.triangle.fill")
                            .font(.subheadline)
                            .symbolEffect(.wiggle.forward.byLayer, options: .repeat(.periodic(delay: 0.0)))
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    CustomPrimaryButtonView(text: "Nueva meta") {
                        showNewGoalSheet.toggle()
                    }
                }
                
                ToolbarItem {
                    
                }
            }
            .navigationTitle("Mis metas")
            .sheet(isPresented: $showNewGoalSheet) {
                NewGoalView()
                    .presentationDetents([.medium])
                    .environment(financeGoalsViewModel)
            }
        }
    }
}

#Preview {
    FinanceGoalsView()
}
