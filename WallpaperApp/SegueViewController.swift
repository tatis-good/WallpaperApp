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
    var selectedImage2: UIImage?
    var authorURL: String?
    var wallPaper: UnsplashPhoto?
    var wallPaper2: UnsplashPhoto?
    var authorName: String?
    var username: String?
    var location: String?
    var updatedAt: String?
    var name: String?
    var unsplashResponse: UnsplashResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = selectedImage {
            imageView.image = image
        }
      
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        
        authorLabel.text = name
        authorLabel.isUserInteractionEnabled = true
        authorLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(authorLabelTapped)))
        sourceLabel.text = location
        updateAtLabel.text = updatedAt
        
      
    }
   


    
    @objc func authorLabelTapped() {
        if let authorURL = authorURL {
            if let url = URL(string: authorURL) {
                UIApplication.shared.open(url)
            }
        }
    }
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
    

    




