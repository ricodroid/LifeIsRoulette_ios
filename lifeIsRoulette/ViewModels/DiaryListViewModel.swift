//
//  DiaryListViewModel.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import SwiftUI

class DiaryListViewModel: ObservableObject {
    @Published var diaries: [Diary] = []

    func addDiary(title: String, content: String, photo: UIImage?) {
        let photoFileName = "\(UUID().uuidString).jpg"
        var photoPath: String? = nil
        
        // 写真をファイルに保存
        if let photo = photo, let savedURL = FileManagerHelper.saveImage(photo, withName: photoFileName) {
            photoPath = savedURL.lastPathComponent  // ファイルパスを保存
        }
        
        // 新しい日記を作成
        let newDiary = Diary(title: title, content: content, photoPath: photoPath)
        diaries.append(newDiary)
        
        // 日記リストを保存
        saveDiaries()
        print("1022 保存された日記: \(diaries)")  // 保存時のデバッグ用
    }

    
    // 永続化のためにUserDefaultsまたは他の方法で保存
    func saveDiaries() {
        if let encoded = try? JSONEncoder().encode(diaries) {
            UserDefaults.standard.set(encoded, forKey: "diaries")
        }
    }
    
    // 保存された日記を読み込む
    func loadDiaries() {
        if let savedData = UserDefaults.standard.data(forKey: "diaries"),
           let decoded = try? JSONDecoder().decode([Diary].self, from: savedData) {
            diaries = decoded
        }
        print("1022 \(diaries)")  // コンソールでデバッグ
    }
}
