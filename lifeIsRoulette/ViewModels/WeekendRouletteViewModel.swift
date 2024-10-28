//
//  WeekendRouletteViewModel.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import Foundation
import SwiftUICore

class WeekendRouletteViewModel: ObservableObject {
    @Published var options: [String] = []
    @Published var rouletteSegments: [RouletteSegment] = []
    
    let removedItemsKey = "removedWeekendRouletteItems"

    init() {
        options = loadWeedEndRouletteItems()
        setupRouletteSegments()
    }
    
    // ルーレット項目を削除するメソッド
    func removeRouletteItem(_ item: String) {
        if let index = options.firstIndex(of: item) {
            options.remove(at: index)
            // 削除された項目をUserDefaultsに保存
            saveRemovedItem(item)
            setupRouletteSegments()  // ルーレットを更新
        }
    }

    private func loadWeedEndRouletteItems() -> [String] {
        guard let url = Bundle.main.url(forResource: "default_weekend_roulette_items", withExtension: "json") else {
            print("JSONファイル 'default_weekend_roulette_items.json' が見つかりません")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            if let items = try JSONSerialization.jsonObject(with: data, options: []) as? [String] {
                // 削除された項目を除外して返す
                let removedItems = getRemovedItems()
                return items.filter { !removedItems.contains($0) }
            } else {
                print("JSONのパースに失敗しました: \(url)")
                return []
            }
        } catch {
            print("JSONファイルの読み込みエラー: \(error)")
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
}
