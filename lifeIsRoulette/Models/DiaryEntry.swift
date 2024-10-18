//
//  DiaryEntry.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import Foundation

struct DiaryEntry: Identifiable {
    let id: UUID
    var title: String
    var content: String
    var date: Date
}
