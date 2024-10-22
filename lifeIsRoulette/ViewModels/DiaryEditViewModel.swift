//
//  DiaryEditViewModel.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/18.
//

import Combine
import Foundation
import UIKit

class DiaryEditViewModel: ObservableObject {
    @Published var title: String
    @Published var content: String
    @Published var photo: UIImage?
    var isNew: Bool

    init(diary: Diary? = nil, title: String = "", content: String = "", photo: UIImage? = nil) {
        self.title = diary?.title ?? title
        self.content = diary?.content ?? content

        // photoPath から写真を読み込む
        if let photoPath = diary?.photoPath, let loadedPhoto = FileManagerHelper.loadImage(from: photoPath) {
            self.photo = loadedPhoto
        } else {
            self.photo = photo
        }

        self.isNew = diary == nil
    }
}
