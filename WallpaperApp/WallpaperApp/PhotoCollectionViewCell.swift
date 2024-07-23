//
//  PhotoCollectionViewCell.swift
//  WallpaperApp
//
//  Created by spark-02 on 2024/06/25.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    var username: String?
    var photo: UnsplashPhoto?
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    //画像・Labelの設定
    func configure(with photo: UnsplashPhoto) {
        authorLabel.text = photo.user.name
        username = photo.user.username
        
        if let url = URL(string: photo.urls.thumb) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(authorLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            authorLabel.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
