//
//  ActionView.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//
import SwiftUI

struct ActionView: View {
    @StateObject var viewModel = ActionViewModel()
    var selectedSegment: RouletteSegment?
    @State private var takenPhoto: UIImage? = nil
    @State private var navigateToDiaryEditView = false

    var body: some View {
        NavigationStack {
            VStack {
                if let label = selectedSegment?.label {
                    Text("選ばれた項目: \(label)")
                        .font(.largeTitle)
                        .padding()
                }

                Text(viewModel.currentAction)
                    .font(.title)
                    .padding()

                // ルーレット結果でアクションを設定するボタン
                Button(action: {
                    viewModel.setActionBasedOnRoulette(result: "新しい挑戦")
                }) {
                    Text("ルーレット結果でアクションを設定")
                        .font(.title2)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                // カスタムアクションを実行するボタン
                Button(action: {
                    viewModel.performCustomAction(actionName: "例のアクション")
                }) {
                    Text("カスタムアクションを実行")
                        .font(.title2)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                // カメラを起動するスワイプボタンを表示
                SwipeToCameraButton(onImageCaptured: { image in
                    self.takenPhoto = image
                    self.navigateToDiaryEditView = true  // 撮影後にDiaryEditViewに遷移
                })  // ← ここで呼び出す
                .padding(.top, 20)  // スペースを追加

                // 撮影した写真をDiaryEditViewに渡して遷移
                .navigationDestination(isPresented: $navigateToDiaryEditView) {
                    if let photo = takenPhoto {
                        DiaryEditView(
                            viewModel: DiaryEditViewModel(photo: photo),
                            onSave: { newDiary in
                                // 保存処理
                            }
                        )
                    }
                }
            }
        }
    }
}
