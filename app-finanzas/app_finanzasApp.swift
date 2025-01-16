//
//  app_finanzasApp.swift
//  app-finanzas
//
//  Created by Jacob on 13-01-25.
//

import SwiftUI

@main
struct app_finanzasApp: App {
    
    @State private var financeGoalsViewModel: FinanceGoalsViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            FinanceGoalsView()
                .environment(financeGoalsViewModel)
        }
    }
}
