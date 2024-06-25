//
//  PhotoCollectionViewCell.swift
//  WallpaperApp
//
//  Created by spark-02 on 2024/06/25.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            contentView.addSubview(imageView)
            imageView.frame = contentView.bounds
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
  
      
}
