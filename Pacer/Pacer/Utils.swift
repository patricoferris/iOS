//
//  Utils.swift
//  Pacer
//
//  Created by Patrick Ferris on 14/09/2018.
//  Copyright © 2018 Patrick Ferris. All rights reserved.
//

import Foundation

var oneMileInKm = 1.60934

class Pace {
    var seconds: Double
    var metric: Bool
    
    init(minutes: Double, seconds: Double, metric: Bool) {
        self.seconds = seconds + (60.0 * minutes)
        self.metric = metric
    }
    
    init(distance: Double, minutes: Double, seconds: Double, metric: Bool) {
        let totalSeconds = seconds + (60 * minutes)
        self.metric = metric
        self.seconds = totalSeconds / distance
    }
    
    func getMinutesAndSeconds(_ s: Double) -> [Int] {
        let minutes = s / 60.0
        let seconds = s.truncatingRemainder(dividingBy: 60.0)
        return [Int(minutes), Int(seconds)]
    }
    
    func getPacePerMile() -> [Int] {
        if metric {
            return getMinutesAndSeconds(self.seconds * oneMileInKm)
        } else {
            return getMinutesAndSeconds(self.seconds)
        }
    }
    
    func getPacePerKm() -> [Int] {
        if metric {
            return getMinutesAndSeconds(self.seconds)
        } else {
            return getMinutesAndSeconds(self.seconds * (1.0 / oneMileInKm))
        }
    }
}

func convertMilesToKm(_ miles: Double) -> Double {
    return miles * oneMileInKm
}

func convertKmToMiles(_ km: Double) -> Double {
    return km * (1 / oneMileInKm)
}
