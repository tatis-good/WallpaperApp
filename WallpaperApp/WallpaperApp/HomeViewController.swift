import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.sectionInsetReference = .fromSafeArea
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
        return collectionView
    }()
    
    private var photos: [[String: Any]] = []
    
    private let AccessKey = "cwcyr_9_PKVl7r8428TGviniDw9af6e2WLp2AjKXahY"
    
    var wallPaper: UnsplashPhoto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        
        fetchRandomPhotos()
    }
    private func fetchRandomPhotos() {
        guard let url = URL(string: "https://api.unsplash.com/photos/?per_page=5&order_by=latest&client_id=\(AccessKey)") else {
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
                } else {
                    print("Error: JSON data is not in the expected format")
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    // ヘッダービューの内容を設定
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
        
        // ヘッダービューの内容を設定する
        headerView.titleLabel.text = "新着写真"
        headerView.titleLabel.textAlignment = .left
        headerView.titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16).isActive = true
        headerView.titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -16).isActive = true
        
        return headerView
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        
        let photoDict = photos[indexPath.item]
        
        if let imageURLString = photoDict["urls"] as? [String: String],
           let regularURLString = imageURLString["regular"],
           let userDict = photoDict["user"] as? [String: Any],
           let authorName = userDict["name"] as? String {
            
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
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Response JSON: \(jsonString)")
                    }
                    
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                        cell.authorLabel.text = authorName
                    }
                }
                task.resume()
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let numberOfItemsPerRow: CGFloat = 2
        let spacingBetweenItems: CGFloat = 10
        
        let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenItems
        let availableWidth = collectionView.bounds.width - edgeInsets.left - edgeInsets.right - totalSpacing
        let itemWidth = availableWidth / numberOfItemsPerRow
        
        if indexPath.item == 0 {
            let topWidth = collectionView.bounds.width - edgeInsets.left - edgeInsets.right
            return CGSize(width: topWidth, height: topWidth)
        } else {
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "HomeSegue", sender: indexPath)
    }
    
    func formatDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: dateString) else { return dateString }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "yyyy年MM月dd日"
        
        return displayFormatter.string(from: date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeSegue",
           let destinationVC = segue.destination as? SegueViewController,
           let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first,
           let selectedCell = collectionView.cellForItem(at: selectedIndexPath) as? PhotoCollectionViewCell,
           let photoDict = photos[safe: selectedIndexPath.item],
           let userDict = photoDict["user"] as? [String: Any],
           let name = userDict["name"] as? String,
           let username = userDict["username"] as? String,
           let updatedAt = photoDict["updated_at"] as? String
        { 
            destinationVC.selectedImage = selectedCell.imageView.image
            destinationVC.wallPaper = wallPaper
            destinationVC.username = username
            destinationVC.name = name
            destinationVC.location = userDict["location"] as? String ?? ""
            destinationVC.authorURL = (userDict["links"] as? [String: Any])?["html"] as? String
            destinationVC.updatedAt = formatDate(updatedAt)
                   
        }
    }

}
extension Collection {
    subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
   
}
