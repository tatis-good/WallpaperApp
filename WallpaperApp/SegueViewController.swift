//
//  SegueViewController.swift
//  WallpaperApp
//
//  Created by spark-02 on 2024/06/28.
//

import UIKit



class SegueViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var updateAtLabel: UILabel!
    
    var selectedImage: UIImage?
    var authorURL: String?
    var wallPaper: UnsplashPhoto?
    var wallPaperColor: UnsplashPhoto?
    var authorName: String?
    var username: String?
    var location: String?
    var updatedAt: String?
    var name: String?
    var unsplashResponse: UnsplashResponse?
    var photo: UnsplashPhoto?
    private var photos: [[String: Any]] = []
    var jaValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画像の表示
        if let image = selectedImage {
            imageView.image = image
        }
        
        //imageViewとLabelにタップジェスチャーの追加、作者・配信地・更新日・タイトルの表示設定
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        
        authorLabel.text = name
        authorLabel.isUserInteractionEnabled = true
        authorLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(authorLabelTapped)))
        sourceLabel.text = location
        updateAtLabel.text = updatedAt
        
        if let jaTitle = jaValue {
            if let title = jaTitle.split(separator: "-").first {
                self.title = String(title)
            } else {
                print("タイトル")
            }
        }
    }
    //作者のURLに遷移する設定
    @objc func authorLabelTapped() {
        if let authorURL = authorURL {
            if let url = URL(string: authorURL) {
                UIApplication.shared.open(url)
            }
        }
    }
    //Segueの設定
    @objc func imageViewTapped(_ gesture: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ImageSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ImageSegue" {
            if let destinationVC = segue.destination as? BigImageViewController {
                destinationVC.image = selectedImage
            }
        }
    }
}







