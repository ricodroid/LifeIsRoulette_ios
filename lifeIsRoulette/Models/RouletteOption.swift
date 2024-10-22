//
//  RouletteOption.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import Foundation

struct RouletteOption: Identifiable {
    let id: UUID
    var name: String
    var type: RouletteType
}

enum RouletteType {
    case weekday
    case weekend
}

func getRandomRouletteItem(from items: [String]) -> String? {
    return items.randomElement()
}
