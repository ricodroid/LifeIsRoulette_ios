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
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
                ForEach(viewModel.diaries) { diary in
                    if let photoPath = diary.photoPath, let photo = FileManagerHelper.loadImage(from: photoPath) {
                        Image(uiImage: photo)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)  // 正方形の画像表示
                            .clipped()
                            .onTapGesture {
                                // 詳細画面へ遷移
                            }
                    }
                }
            }
            .padding(10)
        }
    }
}
