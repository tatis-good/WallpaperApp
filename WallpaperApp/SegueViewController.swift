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
    var photo: UnsplashPhoto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = selectedImage {
            imageView.image = image
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        setupLabels()
//        fetchPhoto()
    }
    
   

    func setupLabels() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(authorLabelTapped))
            authorLabel.isUserInteractionEnabled = true
            authorLabel.addGestureRecognizer(tapGesture)
        }
    
//    func fetchPhoto() {
//           fetchRandomPhotos { [weak self] photo in
//               DispatchQueue.main.async {
//                   guard let photo = photo else { return }
//                   self?.authorLabel.text = "\(photo.user.name)"
//                   self?.sourceLabel.text = "\(photo.location?.name ?? "不明")"
//                   self?.updateAtLabel.text = "\(self?.formatDate(photo.updatedAt) ?? "不明")"
//                   self?.authorURL = photo.user.links.html
//               }
//           }
//       }
    private func fetchRandomPhotos(completion: @escaping ([UnsplashPhoto]?) -> Void) {
         let accessKey = "cwcyr_9_PKVl7r8428TGviniDw9af6e2WLp2AjKXahY"
         guard let url = URL(string: "https://api.unsplash.com/photos/?per_page=5&order_by=latest&client_id=\(accessKey)") else {
             completion(nil)
             return
         }
         
         let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
             if let error = error {
                 print("Error: \(error.localizedDescription)")
                 completion(nil)
                 return
             }
             
             guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                 print("Server responded with an error")
                 completion(nil)
                 return
             }
             
             guard let data = data else {
                 print("No data received")
                 completion(nil)
                 return
             }
             
             do {
                 let photos = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
                 completion(photos)
             } catch {
                 print("Error decoding JSON: \(error.localizedDescription)")
                 completion(nil)
             }
         }
         
         task.resume()
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
    

    




