//
//  DiaryListViewModel.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import SwiftUI

class DiaryListViewModel: ObservableObject {
    @Published var diaries: [Diary] = [
        Diary(title: "日記 1", content: "内容 1"),
        Diary(title: "日記 2", content: "内容 2")
    ]
    
    func addDiary(title: String, content: String) {
        let newDiary = Diary(title: title, content: content)
        diaries.append(newDiary)
    }
    
    func updateDiary(diary: Diary, title: String, content: String) {
        if let index = diaries.firstIndex(where: { $0.id == diary.id }) {
            diaries[index].title = title
            diaries[index].content = content
        }
    }
    
    func deleteDiary(at offsets: IndexSet) {
        diaries.remove(atOffsets: offsets)
    }
}
