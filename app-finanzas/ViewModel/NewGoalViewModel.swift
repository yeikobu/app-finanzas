//
//  NewGoalViewModel.swift
//  Metas Financieras
//
//  Created by Jacob on 12-01-25.
//

import Foundation

@Observable
class NewGoalViewModel {
    
    func checkRequieredFieldsAreNotEmpty(goalName: String, totalToSave: String) -> Bool {
        return !goalName.isEmpty && !totalToSave.isEmpty
    }
    
    func checkFieldGreaterThanZero(field: String) -> Bool {
        guard let fieldValue = Double(field) else { return false }
        return fieldValue > 0
    }
}
