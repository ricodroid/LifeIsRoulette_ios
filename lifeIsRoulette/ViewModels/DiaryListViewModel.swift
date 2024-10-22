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
        
        if let photo = photo, let savedURL = FileManagerHelper.saveImage(photo, withName: photoFileName) {
            photoPath = savedURL.lastPathComponent  // ファイルパスを保存
        }
        
        let newDiary = Diary(title: title, content: content, photoPath: photoPath)
        diaries.append(newDiary)
        saveDiaries()  // 永続化
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
    }
}
