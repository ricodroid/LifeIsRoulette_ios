//
//  SwipeToCameraButton.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/22.
//
import SwiftUI

struct SwipeToCameraButton: View {
    @State private var offset: CGFloat = 0
    @State private var showCamera = false
    let buttonWidth: CGFloat = 300  // ボタン全体の幅
    let buttonHeight: CGFloat = 50  // ボタン全体の高さ
    let circleSize: CGFloat = 50    // スライダーの円のサイズ
    let activationThreshold: CGFloat = 0.6  // カメラを起動するスワイプ距離の閾値（60%）

    var body: some View {
        ZStack {
            // 背景バー
            RoundedRectangle(cornerRadius: buttonHeight / 2)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.4), Color.purple.opacity(0.2)]),
                                     startPoint: .leading, endPoint: .trailing))
                .frame(width: buttonWidth, height: buttonHeight)
            
            // スワイプ可能な円
            HStack {
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                                         startPoint: .top, endPoint: .bottom))
                    .overlay(
                        Image(systemName: "power")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                    )
                    .frame(width: circleSize, height: circleSize)
                    .offset(x: offset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let newOffset = gesture.translation.width
                                // スライド範囲を制限（ボタン幅から円のサイズを引いた分だけ動かす）
                                if newOffset >= 0 && newOffset <= buttonWidth - circleSize {
                                    offset = newOffset
                                }
                            }
                            .onEnded { _ in
                                // カメラを起動する閾値に達した場合
                                if offset >= (buttonWidth - circleSize) * activationThreshold {
                                    withAnimation {
                                        offset = buttonWidth - circleSize  // 右端に固定
                                    }
                                    showCamera = true
                                } else {
                                    // スライダーをリセット
                                    withAnimation {
                                        offset = 0
                                    }
                                }
                            }
                    )
            }
            .frame(width: buttonWidth, height: buttonHeight, alignment: .leading)
        }
        .sheet(isPresented: $showCamera, onDismiss: {
            // カメラ起動後にスライダーをリセット
            withAnimation {
                offset = 0
            }
        }) {
            // カメラの起動処理
            CameraView(onImageCaptured: { image in
                // カメラで撮影した画像を受け取る処理
            }, onDismiss: {
                self.showCamera = false
            })
        }
    }
}
