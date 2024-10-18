//
//  DiaryEditViewModel.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import Combine
import Foundation

class DiaryEditViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var content: String = ""
    
    var isNewEntry: Bool
    var diary: DiaryEntry?
    
    // 初期化時に既存の日記データが渡された場合、そのデータでビューモデルを初期化
    init(diary: DiaryEntry? = nil) {
        if let diary = diary {
            self.title = diary.title
            self.content = diary.content
            self.diary = diary
            self.isNewEntry = false
        } else {
            // 新規作成モード
            self.isNewEntry = true
        }
    }
    
    // 日記を保存するメソッド。新規の場合は新しいDiaryEntryを作成し、既存の場合は更新
    func saveDiary() -> DiaryEntry {
        if isNewEntry {
            return DiaryEntry(id: UUID(), title: title, content: content, date: Date())
        } else {
            // 既存の日記の更新
            diary?.title = title
            diary?.content = content
            return diary!
        }
    }
}
