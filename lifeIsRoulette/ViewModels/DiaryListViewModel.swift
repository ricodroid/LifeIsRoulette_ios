//
//  DiaryListViewModel.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import Combine
import Foundation

class DiaryListViewModel: ObservableObject {
    @Published var diaries: [DiaryEntry] = []
    
    init() {
        loadDiaries()
    }
    
    // 日記をロードするメソッド（後でデータベースやAPIに置き換え可能）
    func loadDiaries() {
        // モックデータ
        diaries = [
            DiaryEntry(id: UUID(), title: "日記1", content: "内容1", date: Date()),
            DiaryEntry(id: UUID(), title: "日記2", content: "内容2", date: Date())
        ]
    }
    
    // 日記を削除するメソッド
    func deleteDiary(at offsets: IndexSet) {
        diaries.remove(atOffsets: offsets)
    }
    
    // 日記を追加するメソッド
    func addDiary(title: String, content: String) {
        let newDiary = DiaryEntry(id: UUID(), title: title, content: content, date: Date())
        diaries.append(newDiary)
    }
    
    // 日記を更新するメソッド
    func updateDiary(diary: DiaryEntry, title: String, content: String) {
        if let index = diaries.firstIndex(where: { $0.id == diary.id }) {
            diaries[index].title = title
            diaries[index].content = content
        }
    }
}

