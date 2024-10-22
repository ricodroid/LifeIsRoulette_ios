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
    @State private var showCamera = false
    @State private var takenPhoto: UIImage? = nil
    @State private var navigateToDiaryEditView = false

    var body: some View {
        VStack {
            if let label = selectedSegment?.label {
                Text("選ばれた項目: \(label)")
                    .font(.largeTitle)
                    .padding()
            }
            
            Text(viewModel.currentAction)
                .font(.title)
                .padding()
            
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
        }
        .gesture(DragGesture(minimumDistance: 50, coordinateSpace: .local)
                    .onEnded { value in
                        if value.translation.width > 0 {
                            showCamera = true
                        }
                    })
        .sheet(isPresented: $showCamera) {
            CameraView(onImageCaptured: { image in
                self.takenPhoto = image
                self.navigateToDiaryEditView = true
            }, onDismiss: {
                self.showCamera = false
            })
        }
        .navigationDestination(isPresented: $navigateToDiaryEditView) {
            if let photo = takenPhoto {
                // DiaryEditView に写真を含む viewModel を渡す
                DiaryEditView(
                    viewModel: DiaryEditViewModel(photo: photo),  // photoを含むviewModelを渡す
                    onSave: { newDiary in
                        // 保存処理
                    }
                )
            }
        }
    }
}
