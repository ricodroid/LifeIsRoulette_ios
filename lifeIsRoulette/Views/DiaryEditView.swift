//
//  DiaryEditView.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import SwiftUI

struct DiaryEditView: View {
    @StateObject var viewModel: DiaryEditViewModel
    var onSave: (Diary) -> Void
    @Environment(\.dismiss) var dismiss

    init(viewModel: DiaryEditViewModel, onSave: @escaping (Diary) -> Void) {
        self._viewModel = StateObject(wrappedValue: viewModel)
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
        .navigationTitle("日記の編集")
    }

    // 日記と写真を保存する処理
    private func saveDiary() {
        var photoPath: String? = nil

        // 写真がある場合はファイルに保存
        if let photo = viewModel.photo {
            let photoFileName = "\(UUID().uuidString).jpg"
            if let savedURL = FileManagerHelper.saveImage(photo, withName: photoFileName) {
                photoPath = savedURL.lastPathComponent  // ファイルパスを取得
            }
        }

        // 日記オブジェクトを作成して保存
        let newDiary = Diary(title: viewModel.title, content: viewModel.content, photoPath: photoPath)
        onSave(newDiary)
        dismiss()
    }
}
