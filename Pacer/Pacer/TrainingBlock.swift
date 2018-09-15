//
//  TrainingBlock.swift
//  Pacer
//
//  Created by Patrick Ferris on 15/09/2018.
//  Copyright © 2018 Patrick Ferris. All rights reserved.
//

import Foundation

class TrainingBlock {
    var metric: Bool
    var date: Date
    var distance: Double
    var goalTime: [Double]
    var type: TrainingType
    
    init(metric: Bool) {
        self.metric = metric
        self.distance = 100.0
        self.goalTime = [2.0, 1.0]
        self.type = TrainingType.Easy
        self.date = Date(timeIntervalSinceNow: 0)
    }
    
    init(metric: Bool, distance: Double, goalTime: [Double], type: TrainingType, date: Date) {
        self.metric = metric
        self.distance = distance
        self.goalTime = goalTime
        self.type = type
        self.date = date
    }
    
    func setDate(_ date: Date) {
        self.date = date
    }
    
    func setDistance(_ distance: Double) {
        self.distance = distance
    }
    
    func setGoalTime(_ goalTime: [Double]) {
        self.goalTime = goalTime
    }
    
    func setType(_ type: TrainingType) {
        self.type = type
    }
    
    func setMetric(_ metric: Bool) {
        self.metric = metric
    }
}

enum TrainingType {
    case Hill, Tempo, Steady, Uptempo, Easy, Long
    
    func toString() -> String {
        switch self {
        case .Easy:
            return "Easy"
        case .Hill:
            return "Hill"
        case .Long:
            return "Long"
        case .Steady:
            return "Steady"
        case .Tempo:
            return "Tempo"
        case .Uptempo:
            return "Uptempo"
        }
    }
}
