//
//  DiaryEditView.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import SwiftUI

struct DiaryEditView: View {
    @ObservedObject var viewModel: DiaryEditViewModel
    var onSave: (Diary) -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            if let photo = viewModel.photo {
                Image(uiImage: photo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }
            
            TextField("タイトル", text: $viewModel.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextEditor(text: $viewModel.content)
                .frame(height: 200)
                .border(Color.gray, width: 1)
                .padding()
            
            Button(action: {
                let newDiary = Diary(title: viewModel.title, content: viewModel.content)
                onSave(newDiary)
                dismiss()  // 保存後に前の画面に戻る
            }) {
                Text("保存")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationTitle(viewModel.isNew ? "新しい日記" : "日記を編集")
        .padding()
    }
}
