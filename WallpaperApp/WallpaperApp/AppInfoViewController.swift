//
//  AppInfoViewController.swift
//  WallpaperApp
//
//  Created by spark-02 on 2024/07/01.
//

import UIKit
import SafariServices
class AppInfoViewController: UIViewController {

    let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true
            return imageView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
                imageView.frame = view.bounds
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageViewTap))
                imageView.addGestureRecognizer(tapGesture)
        
    }
    @objc func handleImageViewTap() {
           guard let url = URL(string: "https://unsplash.com") else { return }
           let safariViewController = SFSafariViewController(url: url)
           present(safariViewController, animated: true, completion: nil)
       }
   }


