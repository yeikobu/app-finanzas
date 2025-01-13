//
//  FinanceGoalsViewModel.swift
//  app-finanzas
//
//  Created by Jacob Aguilar on 13-01-25.
//

import Foundation

@Observable
class FinanceGoalsViewModel {
    var financeGoals: [FinanceGoalModel]
    
    init(financeGoals: [FinanceGoalModel] = []) {
        self.financeGoals = financeGoals
    }
    
    func addFinanceGoal(financeGoal: FinanceGoalModel) {
        financeGoals.append(financeGoal)
        print(financeGoals)
    }
}
