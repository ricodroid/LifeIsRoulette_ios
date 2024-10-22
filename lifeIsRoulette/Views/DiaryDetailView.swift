//
//  DiaryDetailView.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/22.
//
import SwiftUI

import SwiftUI

struct DiaryDetailView: View {
    @StateObject var viewModel: DiaryEditViewModel
    var onSave: (Diary) -> Void
    @Environment(\.dismiss) var dismiss

    init(diary: Diary, onSave: @escaping (Diary) -> Void) {
        self._viewModel = StateObject(wrappedValue: DiaryEditViewModel(diary: diary))
        self.onSave = onSave
    }

    var body: some View {
        VStack {
            if let photo = viewModel.photo {
                Image(uiImage: photo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            }

            TextField("タイトル", text: $viewModel.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextEditor(text: $viewModel.content)
                .frame(height: 200)
                .border(Color.gray, width: 1)
                .padding()

            Button(action: {
                saveDiary()
            }) {
                Text("保存")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("日記の詳細")
    }

    // 写真を保存して日記を更新
    private func saveDiary() {
        var photoPath: String? = nil

        // 写真がある場合はファイルに保存
        if let photo = viewModel.photo {
            let photoFileName = "\(UUID().uuidString).jpg"
            if let savedURL = FileManagerHelper.saveImage(photo, withName: photoFileName) {
                photoPath = savedURL.lastPathComponent  // ファイルパスを取得
            }
        }

        // Diaryオブジェクトを更新
        let updatedDiary = Diary(title: viewModel.title, content: viewModel.content, photoPath: photoPath)
        onSave(updatedDiary)
        dismiss()  // 保存後に戻る
    }
}
