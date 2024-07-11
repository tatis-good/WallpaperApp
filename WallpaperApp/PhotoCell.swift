//
//  PhotoCell.swift
//  WallpaperApp
//
//  Created by spark-02 on 2024/07/03.
//

import UIKit



class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    
    var photoDict: [String: Any]?
    var photo: UnsplashPhoto?
    override func prepareForReuse() {
        super.prepareForReuse()
        // セルを再利用する前に必要な初期化を行う
        imageView.image = nil
    }
    
    func configure(with photo: UnsplashPhoto) {
        authorLabel.text = photo.user.name
        authorLabel.textColor = .black
        authorLabel.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        authorLabel.font = UIFont.systemFont(ofSize: 12)
        authorLabel.textAlignment = .right
        
        self.photo = photo
                self.photoDict = [
                    "user": [
                        "name": photo.user.name,
                        "username": photo.user.username,
                        "location": photo.user.location
                    ],
                    "updated_at": photo.updatedAt
                ]
        if let url = URL(string: photo.urls.regular) {
            // 非同期に画像を読み込む
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        // セルがまだ表示されている場合のみ画像を設定する
                        self.imageView.image = image
                    }
                }
            }
        }
    }
}


