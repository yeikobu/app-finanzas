//
//  FinanceGoalsView.swift
//  Metas Financieras
//
//  Created by Jacob on 12-01-25.
//

import SwiftUI

struct FinanceGoalsView: View {
    
    @State private var goalTextToSearch: String = ""
    @State private var showNewGoalSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                
            }
            .searchable(text: $goalTextToSearch, prompt: "Buscar meta")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    CustomPrimaryButtonView(text: "Nueva meta") {
                        showNewGoalSheet.toggle()
                    }
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
