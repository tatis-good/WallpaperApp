//
//  PhotoCell.swift
//  WallpaperApp
//
//  Created by spark-02 on 2024/07/03.
//

import UIKit

struct UnsplashPhotos: Decodable {
    let id: String
    let urls: UnsplashPhotoURLs
}

struct UnsplashPhotoURLs: Decodable {
    let regular: String
}

struct UnsplashResponse: Decodable {
    let results: [UnsplashPhoto]
}

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with photo: UnsplashPhoto) {
            guard let url = URL(string: photo.urls.regular) else {
                return
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }


