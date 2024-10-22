//
//  DiaryListView.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//
import SwiftUI

struct DiaryListView: View {
    @StateObject var viewModel = DiaryListViewModel()
    @ObservedObject var diaryListViewModel: DiaryListViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(viewModel.diaries, id: \.id) { diary in
                        VStack {
                            if let photoPath = diary.photoPath,
                               let image = FileManagerHelper.loadImage(from: photoPath) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()   // 画像をビューに合わせて拡大縮小
                                    .frame(width: 150, height: 150)  // 正方形に設定
                                    .clipped()  // 画像が正方形の枠からはみ出さないようにクリップ
                            } else {
                                // 写真がない場合のプレースホルダー
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 150, height: 150)
                            }

                            Text(diary.title)
                                .font(.headline)
                                .padding(.top, 8)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Diary List")
            .onAppear {
                viewModel.loadDiaries()  // 日記を読み込み
            }
        }
    }
}
