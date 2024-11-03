//
//  ActionView.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//
import SwiftUI

struct ActionView<VM: ObservableObject>: View {
    @StateObject var viewModel = ActionViewModel()
    var selectedSegment: RouletteSegment?
    @State private var takenPhoto: UIImage? = nil
    @State private var navigateToDiaryEditView = false
    @ObservedObject var rouletteViewModel: VM  // ジェネリック対応に戻す
    @State private var showDeleteDialog = false  // ダイアログ表示フラグ

    var body: some View {
        NavigationStack {
            VStack {
                if let label = selectedSegment?.label {
                    Text("選ばれた項目: \(label)")
                        .font(.largeTitle)
                        .padding()
                }

                Text(viewModel.currentAction)
                   .font(.title2)
                   .foregroundColor(.secondary)
                   .multilineTextAlignment(.center)
                   .padding([.leading, .trailing], 24)

                // カメラを起動するスワイプボタンを表示
                SwipeToCameraButton(onImageCaptured: { image in
                    self.takenPhoto = image
                    self.navigateToDiaryEditView = true  // 撮影後にDiaryEditViewに遷移
                })
                .padding(.top, 20)

                // 撮影した写真をDiaryEditViewに渡して遷移
                .navigationDestination(isPresented: $navigateToDiaryEditView) {
                    if takenPhoto != nil {
                        DiaryEditView(
                            viewModel: DiaryEditViewModel(photo: takenPhoto),
                            onSave: { newDiary in
                                // ActionViewModel内のdiaryListViewModelに日記を追加
                                viewModel.diaryListViewModel.addDiary(
                                    title: newDiary.title,
                                    content: newDiary.content,
                                    photo: takenPhoto
                                )  // 日記と写真を保存
                            }
                        )
                    }
                }

                // 項目削除ダイアログの表示トリガー
                Button(action: {
                    showDeleteDialog = true  // ダイアログを表示
                }) {
                    Text("項目を削除")
                        .font(.title2)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showDeleteDialog) {
                    Alert(
                        title: Text("項目の削除"),
                        message: Text("\(selectedSegment?.label ?? "") をルーレットから削除しますか？"),
                        primaryButton: .destructive(Text("削除")) {
                            if let segment = selectedSegment {
                                removeSegment(segment)
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
    }

    // 項目を削除するメソッド
    private func removeSegment(_ segment: RouletteSegment) {
        let label = segment.label  // Optionalではないので直接使用
        if let viewModel = rouletteViewModel as? WeekdayRouletteViewModel {
            viewModel.removeRouletteItem(label)
        } else if let viewModel = rouletteViewModel as? WeekendRouletteViewModel {
            viewModel.removeRouletteItem(label)
        }
        navigateToDiaryEditView = true  // DiaryEditViewに遷移
    }

}
