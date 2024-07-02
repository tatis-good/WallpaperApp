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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = selectedImage {
            imageView.image = image
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        setupLabels()
        fetchPhoto()
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

    func setupLabels() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(authorLabelTapped))
            authorLabel.isUserInteractionEnabled = true
            authorLabel.addGestureRecognizer(tapGesture)
        }
    
    func fetchPhoto() {
           fetchUnsplashPhoto { [weak self] photo in
               DispatchQueue.main.async {
                   guard let photo = photo else { return }
                   self?.authorLabel.text = "\(photo.user.name)"
                   self?.sourceLabel.text = "\(photo.location?.name ?? "不明")"
                   self?.updateAtLabel.text = "\(self?.formatDate(photo.updatedAt) ?? "不明")"
                   self?.authorURL = photo.user.links.html
               }
           }
       }

       func formatDate(_ dateString: String) -> String {
           let formatter = ISO8601DateFormatter()
           guard let date = formatter.date(from: dateString) else { return dateString }
           
           let displayFormatter = DateFormatter()
           displayFormatter.dateFormat = "yyyy年MM月dd日"
           
           return displayFormatter.string(from: date)
       }

       @objc func authorLabelTapped() {
           guard let authorURL = authorURL, let url = URL(string: authorURL) else { return }
           UIApplication.shared.open(url, options: [:], completionHandler: nil)
       }
   }
    

    




