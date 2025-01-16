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
    
    func deleteGoal(goal: FinanceGoalModel) -> Bool {
        financeGoals.removeAll(where: { $0.id == goal.id })
        return true
    }
    
    func getTotalSaved(contributions: [ContributionModel]) -> Double {
        return contributions.reduce(0.0) { $0 + $1.amount }
    }
    
    func addContribution(contribution: ContributionModel) {
        for index in financeGoals.indices {
            financeGoals[index].contributions.append(contribution)
            financeGoals[index].alreadySaved = getTotalSaved(contributions: financeGoals[index].contributions)
        }
    }
}
