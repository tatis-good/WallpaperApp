//
//  HomeViewController.swift
//  WallpaperApp
//
//  Created by spark-02 on 2024/06/25.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        return collectionView
    }()
    
    private var photos: [[String: Any]] = []
    
    
    
    
    
    private let AccessKey = "cwcyr_9_PKVl7r8428TGviniDw9af6e2WLp2AjKXahY"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        fetchRandomPhotos()
        
    }
    
    private func fetchRandomPhotos() {
        guard let url = URL(string: "https://api.unsplash.com/photos/?per_page=5&order=by=latest&client_id=\(AccessKey)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server responded with an error")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                if let jsonArray = json as? [[String: Any]] {
                    DispatchQueue.main.async {
                        self?.photos = jsonArray
                        self?.collectionView.reloadData()
                    }
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        
        let photoDict = photos[indexPath.item]
        
        if let imageURLString = photoDict["urls"] as? [String: String],
           let regularURLString = imageURLString["regular"] {
            if let imageURL = URL(string: regularURLString) {
                let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let data = data, let image = UIImage(data: data) else {
                        print("Error creating image from data")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                    }
                }
                task.resume()
            }
        }
        
        return cell
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            
            let topWidth = collectionView.bounds.width - 32
            return CGSize(width: topWidth, height: topWidth)
        } else {
            
            let otherWidth = (collectionView.bounds.width - 32)/2
            return CGSize(width: otherWidth, height: otherWidth)
        }
    }
}

