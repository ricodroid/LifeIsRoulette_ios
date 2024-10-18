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
