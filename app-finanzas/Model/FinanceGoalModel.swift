//
//  FinanceGoalModel.swift
//  Metas Financieras
//
//  Created by Jacob on 12-01-25.
//

import Foundation

struct FinanceGoalModel {
    var id: UUID = UUID()
    var name: String
    var totalToSave: Double
    var alreadySaved: Double?
    var deadline: Date?
    var createdAt: Date
    
    var getAlreadySaveAmount: Double {
        alreadySaved ?? 0.0
    }
    
    init(id: UUID, name: String, totalToSave: Double, alreadySaved: Double? = 0.0, deadline: Date? = nil, createdAt: Date = .now) {
        self.id = id
        self.name = name
        self.totalToSave = totalToSave
        self.alreadySaved = alreadySaved
        self.deadline = deadline
        self.createdAt = createdAt
    }
}
