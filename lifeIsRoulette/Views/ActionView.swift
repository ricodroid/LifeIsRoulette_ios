//
//  ActionView.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import SwiftUI

struct ActionView: View {
    @StateObject var viewModel = ActionViewModel()
    
    var body: some View {
        VStack {
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
    }
}
