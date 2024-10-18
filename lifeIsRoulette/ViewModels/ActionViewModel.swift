//
//  ActionViewModel.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import Foundation

class ActionViewModel: ObservableObject {
    @Published var currentAction: String = ""
    
    // ルーレット結果に基づいたアクションを設定する
    func setActionBasedOnRoulette(result: String) {
        currentAction = "次のアクションは: \(result)"
    }
    
    // 任意のアクションを実行する
    func performCustomAction(actionName: String) {
        // アクションの実行ロジック
        currentAction = "アクション \(actionName) を実行しました。"
    }
}
