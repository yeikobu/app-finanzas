//
//  FinanceGoalModel.swift
//  Metas Financieras
//
//  Created by Jacob on 12-01-25.
//

import Foundation

struct FinanceGoalModel: Hashable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var totalToSave: Double
    var alreadySaved: Double?
    var deadline: Date?
    var createdAt: Date
    var contributions: [ContributionModel]
    
    var getAlreadySaveAmount: Double {
        alreadySaved ?? 0.0
    }
    
    init(id: UUID = UUID(), name: String, totalToSave: Double, alreadySaved: Double? = 0.0, deadline: Date? = nil, createdAt: Date = .now, contributions: [ContributionModel] = []) {
        self.id = id
        self.name = name
        self.totalToSave = totalToSave
        self.alreadySaved = alreadySaved
        self.deadline = deadline
        self.createdAt = createdAt
        self.contributions = contributions
    }
}


struct ContributionModel: Hashable, Identifiable {
    var id = UUID()
    var date: Date
    var amount: Double
    
    init(id: UUID = UUID(), date: Date, amount: Double) {
        self.id = id
        self.date = date
        self.amount = amount
    }
}
