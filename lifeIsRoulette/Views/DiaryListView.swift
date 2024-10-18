//
//  DiaryListView.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import SwiftUI

struct DiaryListView: View {
    @StateObject var viewModel = DiaryListViewModel()
    
    var body: some View {
        List {
            // 既存の日記の編集
            ForEach(viewModel.diaries) { diary in
                NavigationLink(destination: DiaryEditView(viewModel: DiaryEditViewModel(diary: diary), onSave: { updatedDiary in
                    viewModel.updateDiary(diary: updatedDiary, title: updatedDiary.title, content: updatedDiary.content)
                })) {
                    Text(diary.title)
                }
            }
            .onDelete(perform: viewModel.deleteDiary) // 削除機能
        }
        .navigationTitle("日記一覧")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                // 新しい日記の追加
                NavigationLink(destination: DiaryEditView(viewModel: DiaryEditViewModel(), onSave: { newDiary in
                    viewModel.addDiary(title: newDiary.title, content: newDiary.content)
                })) {
                    Text("追加")
                }
            }
        }
    }
}
