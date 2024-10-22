//
//  Diary.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/22.
//

import Foundation
import UIKit

struct Diary: Identifiable, Codable {
    var id = UUID()
    var title: String
    var content: String
    var photoPath: String?  // 写真のファイルパスを保存
}
