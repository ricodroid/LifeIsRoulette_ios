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
       
       init() {
           options = loadWeedDayRouletteItems()
           setupRouletteSegments()
       }
    
    private func loadWeedDayRouletteItems() -> [String] {
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
    
        private func setupRouletteSegments() {
           let randomOptions = options.shuffled().prefix(10) // ランダムに9項目を選択
           rouletteSegments = randomOptions.enumerated().map { index, option in
               RouletteSegment(number: index + 1, label: option, color: randomColor())
           }
       }
       
    private func randomColor() -> Color {
        // 25色のカラーパレットを用意
        let colors: [Color] = [
            .yellow, .orange, .red, .pink, .purple, .blue, .cyan, .green, .mint,
            .indigo, .brown, .gray, .teal, .white, .mint, .secondary, .teal
        ]
        
        return colors.randomElement() ?? .gray
    }

}
