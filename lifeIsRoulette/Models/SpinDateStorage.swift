//
//  SpinDateStorage.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/22.
//

import Foundation

class SpinDateStorage {
    static let shared = SpinDateStorage()
    private let spinDatesKey = "spinDates"
    
    // 日付をUserDefaultsに保存
    func saveSpinDates(_ dates: Set<Date>) {
        let dateArray = dates.map { $0.timeIntervalSince1970 } // DateをTimeIntervalに変換
        UserDefaults.standard.set(dateArray, forKey: spinDatesKey)
    }
    
    // 保存された日付をUserDefaultsから読み込み
    func loadSpinDates() -> Set<Date> {
        if let savedDates = UserDefaults.standard.array(forKey: spinDatesKey) as? [TimeInterval] {
            let dates = savedDates.map { Date(timeIntervalSince1970: $0) }
            return Set(dates) // 重複を避けるためにSetに変換
        } else {
            return []
        }
    }
}

