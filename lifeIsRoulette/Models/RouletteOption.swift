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

func loadWeedDayRouletteItems() -> [String] {
    guard let url = Bundle.main.url(forResource: "default_weed_day_roulette_items", withExtension: "json") else {
        print("JSONファイルが見つかりません")
        return []
    }

    do {
        let data = try Data(contentsOf: url)
        if let items = try JSONSerialization.jsonObject(with: data, options: []) as? [String] {
            return items
        } else {
            print("JSONのパースに失敗しました")
            return []
        }
    } catch {
        print("JSONファイルの読み込みエラー: \(error)")
        return []
    }
}

func getRandomRouletteItem(from items: [String]) -> String? {
    return items.randomElement()
}
