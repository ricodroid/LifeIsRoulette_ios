//
//  WeekdayRouletteViewModel.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import Combine
import Foundation

class WeekdayRouletteViewModel: ObservableObject {
    @Published var options: [RouletteOption] = []
    let rouletteSegments: [RouletteSegment] = [
        RouletteSegment(number: 1, color: .yellow),
        RouletteSegment(number: 2, color: .orange),
        RouletteSegment(number: 3, color: .red),
        RouletteSegment(number: 4, color: .pink),
        RouletteSegment(number: 5, color: .purple),
        RouletteSegment(number: 6, color: .blue),
        RouletteSegment(number: 7, color: .cyan),
        RouletteSegment(number: 8, color: .green),
        RouletteSegment(number: 9, color: .mint)
    ]
    
    init() {
        options = loadWeekdayOptions()
    }
    
    private func loadWeekdayOptions() -> [RouletteOption] {
        return [
            RouletteOption(id: UUID(), name: "Option 1", type: .weekday),
            RouletteOption(id: UUID(), name: "Option 2", type: .weekday)
        ]
    }
    
    func spinRoulette() {
        // ルーレットを回すロジックをここに実装
    }
}
