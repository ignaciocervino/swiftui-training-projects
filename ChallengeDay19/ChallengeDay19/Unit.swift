//
//  Unit.swift
//  ChallengeDay19
//
//  Created by Ignacio Cervino on 27/07/2023.
//

import Foundation

enum Unit: String, CaseIterable {
    case meters
    case kilometers
    case feet
    case yards
    case miles
}

extension Unit {
    func convertToMeter(value: Double) -> Double {
        switch self {
        case .feet:
            return value / 3.281
        case .meters:
            return value
        case .kilometers:
            return value * 1000
        case .yards:
            return value / 1.094
        case .miles:
            return value * 1609
        }
    }
}
