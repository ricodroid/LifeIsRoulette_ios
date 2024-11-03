//
//  AddRouletteItemViewModel.swift
//  lifeIsRoulette
//
//  Created by riko on 2024/11/03.
//

import Foundation


// Model
struct RouletteItem: Identifiable, Codable {
    var id = UUID()
    var name: String
}

// ViewModel
class AddRouletteItemViewModel: ObservableObject {
    @Published var weekDayItems: [RouletteItem] = []
    @Published var weekEndItems: [RouletteItem] = []
    @Published var newItemName: String = ""
    @Published var isWeekDay: Bool = true // true for WeekDay, false for WeekEnd

    private let weekDayKey = "weekDayItems"
    private let weekEndKey = "weekEndItems"

    init() {
        loadItems()
    }

    func loadItems() {
        if let weekDayData = UserDefaults.standard.data(forKey: weekDayKey),
           let decodedWeekDayItems = try? JSONDecoder().decode([RouletteItem].self, from: weekDayData) {
            weekDayItems = decodedWeekDayItems
        }
        
        if let weekEndData = UserDefaults.standard.data(forKey: weekEndKey),
           let decodedWeekEndItems = try? JSONDecoder().decode([RouletteItem].self, from: weekEndData) {
            weekEndItems = decodedWeekEndItems
        }
    }

    func saveItems() {
        if let weekDayData = try? JSONEncoder().encode(weekDayItems) {
            UserDefaults.standard.set(weekDayData, forKey: weekDayKey)
        }
        
        if let weekEndData = try? JSONEncoder().encode(weekEndItems) {
            UserDefaults.standard.set(weekEndData, forKey: weekEndKey)
        }
    }

    func addItem() {
        let newItem = RouletteItem(name: newItemName)
        
        if isWeekDay {
            weekDayItems.append(newItem)
        } else {
            weekEndItems.append(newItem)
        }
        
        saveItems()
        newItemName = ""
    }

    func deleteItem(at offsets: IndexSet, isWeekDayList: Bool) {
        if isWeekDayList {
            weekDayItems.remove(atOffsets: offsets)
        } else {
            weekEndItems.remove(atOffsets: offsets)
        }
        saveItems()
    }
}
