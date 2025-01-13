//
//  FinanceGoalsView.swift
//  Metas Financieras
//
//  Created by Jacob on 12-01-25.
//

import SwiftUI

struct FinanceGoalsView: View {
    
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
            Picker("", selection: $selectedOption) {
                ForEach(SegmentedControlOption.allCases) { option in
                    Text(option.rawValue.capitalized)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 10)
            
            List {
                
            }
            .searchable(text: $goalTextToSearch, prompt: "Buscar meta")
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
            }
        }
    }
}

#Preview {
    FinanceGoalsView()
}
