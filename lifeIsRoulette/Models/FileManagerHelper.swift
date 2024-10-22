//
//  FileManagerHelper.swift
//  lifeIsRoulette
//
//  Created by r_murata on 2024/10/22.
//
import UIKit

class FileManagerHelper {
    
    // 画像を保存する
    static func saveImage(_ image: UIImage, withName name: String) -> URL? {
        guard let data = image.jpegData(compressionQuality: 1.0) else { return nil }
        let filename = getDocumentsDirectory().appendingPathComponent(name)
        
        do {
            try data.write(to: filename)
            return filename
        } catch {
            print("画像の保存に失敗しました: \(error)")
            return nil
        }
    }
    
    // 画像を読み込む
    static func loadImage(from path: String) -> UIImage? {
        let url = getDocumentsDirectory().appendingPathComponent(path)
        if let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        }
        return nil
    }
    
    // ドキュメントディレクトリのパスを取得する
    static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
