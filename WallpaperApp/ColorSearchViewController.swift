
import UIKit


class ColorSearchViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var photos: [UnsplashPhoto] = []
    let AccessKey = "cwcyr_9_PKVl7r8428TGviniDw9af6e2WLp2AjKXahY"
    var wallPaper2: UnsplashPhoto?
    
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        fetchPhotos(for: "red")
    }
    
    @IBAction func redButton(_ sender: UIButton) {
        updateButtonStyles(except: sender)
        fetchPhotos(for: "red")
    }
    
    @IBAction func blueButton(_ sender: UIButton) {
        updateButtonStyles(except: sender)
        fetchPhotos(for: "blue")
    }
    
    @IBAction func greenButton(_ sender: UIButton) {
        updateButtonStyles(except: sender)
        fetchPhotos(for: "green")
    }
    
    @IBAction func yellowButton(_ sender: UIButton) {
        updateButtonStyles(except: sender)
        fetchPhotos(for: "yellow")
    }
    
    @IBAction func whiteButton(_ sender: UIButton) {
        updateButtonStyles(except: sender)
        fetchPhotos(for: "white")
    }
    
    @IBAction func blackButton(_ sender: UIButton) {
        updateButtonStyles(except: sender)
        fetchPhotos(for: "black")
    }
    
    func updateButtonStyles(except selectedButton: UIButton) {
            for button in buttons {
                if button == selectedButton {
                    // 押されたボタンのスタイルを変更（例：背景色を変更）
                    button.setTitleColor(.white, for: .normal)
                    button.backgroundColor = .black
                } else {
                    // 押されていないボタンのスタイルを変更
                    button.setTitleColor(.black, for: .normal)
                    button.backgroundColor = .white
                }
            }
        }
    
    func fetchPhotos(for color: String) {
        let urlString = "https://api.unsplash.com/search/photos?query=\(color)&per_page=5&color=\(color)&client_id=\(AccessKey)"
        print(urlString)
        guard let url = URL(string: urlString) else {
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
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Response JSON: \(jsonString)")
            }
            
            do {
                let response = try JSONDecoder().decode(UnsplashResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.photos = response.results
                    self?.collectionView.reloadData()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! PhotoCell
        let photo = photos[indexPath.row]
        cell.configure(with: photo)
        return cell
    }
    
    
    func getImage(from urlString: String) -> UIImage? {
        guard let url = URL(string: urlString), let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let spacingBetweenItems: CGFloat = 10
        
        if indexPath.item == 0 {
            // 一枚目のセルは全幅を使う
            let topWidth = collectionView.bounds.width - edgeInsets.left - edgeInsets.right
            return CGSize(width: topWidth, height: topWidth)
        } else {
            // 二枚目以降のセルは二分割
            let numberOfItemsPerRow: CGFloat = 2
            let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenItems + edgeInsets.left + edgeInsets.right
            let availableWidth = collectionView.bounds.width - totalSpacing
            let itemWidth = availableWidth / numberOfItemsPerRow
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)  // 左右の余白を統一
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    func formatDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: dateString) else { return dateString }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "yyyy年MM月dd日"
        
        return displayFormatter.string(from: date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhotoDetail",
           let destinationVC = segue.destination as? SegueViewController,
           let selectedCell = sender as? PhotoCell,
           let selectedImage = selectedCell.imageView.image,
           let photoDict = selectedCell.photoDict,
           let userDict = photoDict["user"] as? [String: Any],
           let name = userDict["name"] as? String,
           let username = userDict["username"] as? String,
           let location = userDict["location"] as? String,
           let updatedAt = photoDict["updated_at"] as? String {
            
            destinationVC.selectedImage = selectedImage
            destinationVC.wallPaper2 = wallPaper2
            destinationVC.name = name
            destinationVC.username = username
            destinationVC.location = location
            destinationVC.authorURL = (userDict["links"] as? [String: Any])?["html"] as? String
            destinationVC.updatedAt = formatDate(updatedAt)
            
        }
    }
}
