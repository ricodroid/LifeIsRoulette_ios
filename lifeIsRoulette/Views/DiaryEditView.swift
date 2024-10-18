//
//  DiaryEditView.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import SwiftUI

struct DiaryEditView: View {
    @StateObject var viewModel: DiaryEditViewModel
    @Environment(\.presentationMode) var presentationMode
    var onSave: (DiaryEntry) -> Void
    
    var body: some View {
        VStack {
            TextField("タイトルを入力", text: $viewModel.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextEditor(text: $viewModel.content)
                .border(Color.gray, width: 1)
                .padding()
            
            Button(action: {
                let savedDiary = viewModel.saveDiary()
                onSave(savedDiary)
                presentationMode.wrappedValue.dismiss() // 画面を閉じる
            }) {
                Text("保存")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationTitle(viewModel.isNewEntry ? "新しい日記" : "日記の編集")
        .padding()
    }
}
