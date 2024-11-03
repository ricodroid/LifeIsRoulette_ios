//
//  WeekdayRouletteViewModel.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import Combine
import Foundation
import SwiftUI

class WeekdayRouletteViewModel: ObservableObject {
    @Published var options: [String] = []
    @Published var rouletteSegments: [RouletteSegment] = []
    
    let removedItemsKey = "removedWeekdayRouletteItems"
    
    init() {
        options = loadWeedDayRouletteItems()
        setupRouletteSegments()
    }

    // 項目を削除するメソッド
    func removeRouletteItem(_ item: String) {
        if let index = options.firstIndex(of: item) {
            options.remove(at: index)
            // 削除された項目をUserDefaultsに保存
            saveRemovedItem(item)
            setupRouletteSegments()  // ルーレットを更新
        }
    }
    
    private func loadWeedDayRouletteItems() -> [String] {
        guard let url = Bundle.main.url(forResource: "default_weekend_roulette_items", withExtension: "json") else {
            print("JSON file 'default_weekend_roulette_items.json' not found")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            if let items = try JSONSerialization.jsonObject(with: data, options: []) as? [String] {
                let removedItems = getRemovedItems()
                // Load and include UserDefaults-saved weekend items
                let savedWeekEndItems = loadWeekDayItems()
                return (items + savedWeekEndItems).filter { !removedItems.contains($0) }
            } else {
                print("Failed to parse JSON: \(url)")
                return []
            }
        } catch {
            print("Error loading JSON: \(error)")
            return []
        }
    }

    // 削除された項目をUserDefaultsに保存
    private func saveRemovedItem(_ item: String) {
        var removedItems = getRemovedItems()
        removedItems.append(item)
        UserDefaults.standard.set(removedItems, forKey: removedItemsKey)
    }

    // 削除された項目をUserDefaultsから取得
    private func getRemovedItems() -> [String] {
        return UserDefaults.standard.stringArray(forKey: removedItemsKey) ?? []
    }

    private func setupRouletteSegments() {
        let randomOptions = options.shuffled().prefix(10)
        rouletteSegments = randomOptions.enumerated().map { index, option in
            RouletteSegment(number: index + 1, label: option, color: randomColor())
        }
    }

    private func randomColor() -> Color {
        let colors: [Color] = [
            .yellow, .orange, .red, .pink, .purple, .blue, .cyan, .green, .mint,
            .indigo, .brown, .gray, .teal, .white, .mint, .secondary, .teal
        ]
        return colors.randomElement() ?? .gray
    }
    
    private func loadWeekDayItems() -> [String] {
        guard let data = UserDefaults.standard.data(forKey: "weekDayItems"),
              let items = try? JSONDecoder().decode([RouletteItem].self, from: data) else {
            return []
        }
        return items.map { $0.name }
    }
}
