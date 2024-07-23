
import UIKit


class ColorSearchViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var photos: [UnsplashPhoto] = []
    private  let AccessKey = "cwcyr_9_PKVl7r8428TGviniDw9af6e2WLp2AjKXahY"
    var wallPaperColor: UnsplashPhoto?
    var redButtonSelected = true
    var blueButtonSelected = false
    var greenButtonSelected = false
    var yellowButtonSelected = false
    var whiteButtonSelected = false
    var blackButtonSelected = false
    var buttons: [UIButton] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        buttons = [redButton, blueButton, greenButton,yellowButton,whiteButton,blackButton]
        setButtonColors()
        fetchPhotos(for: "red")
    }
    //レッドの写真表示
    @IBAction func redButton(_ sender: UIButton) {
        redButtonSelected = true
        blueButtonSelected = false
        greenButtonSelected = false
        yellowButtonSelected = false
        whiteButtonSelected = false
        blackButtonSelected = false
        setButtonColors()
        fetchPhotos(for: "red")
    }
    //ブルーの写真表示
    @IBAction func blueButton(_ sender: UIButton) {
        redButtonSelected = false
        blueButtonSelected = true
        greenButtonSelected = false
        yellowButtonSelected = false
        whiteButtonSelected = false
        blackButtonSelected = false
        setButtonColors()
        fetchPhotos(for: "blue")
    }
    //グリーンの写真表示
    @IBAction func greenButton(_ sender: UIButton) {
        redButtonSelected = false
        blueButtonSelected = false
        greenButtonSelected = true
        yellowButtonSelected = false
        whiteButtonSelected = false
        blackButtonSelected = false
        setButtonColors()
        fetchPhotos(for: "green")
    }
    //イエローの写真表示
    @IBAction func yellowButton(_ sender: UIButton) {
        redButtonSelected = false
        blueButtonSelected = false
        greenButtonSelected = false
        yellowButtonSelected = true
        whiteButtonSelected = false
        blackButtonSelected = false
        setButtonColors()
        fetchPhotos(for: "yellow")
    }
    //ホワイトの写真表示
    @IBAction func whiteButton(_ sender: UIButton) {
        redButtonSelected = false
        blueButtonSelected = false
        greenButtonSelected = false
        yellowButtonSelected = false
        whiteButtonSelected = true
        blackButtonSelected = false
        setButtonColors()
        fetchPhotos(for: "white")
    }
    //ブラックの写真表示
    @IBAction func blackButton(_ sender: UIButton) {
        redButtonSelected = false
        blueButtonSelected = false
        greenButtonSelected = false
        yellowButtonSelected = false
        whiteButtonSelected = false
        blackButtonSelected = true
        setButtonColors()
        fetchPhotos(for: "black")
    }
    //ボタン詳細設定
    func setButtonColors() {
        for button in buttons {
            // 全てのボタンにデフォルトのスタイルを設定
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 8.0
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            
            // redButtonが選択されている場合
            if button == redButton && redButtonSelected {
                button.backgroundColor = .black
                button.tintColor = .white
                
                // redButton以外をデフォルトの設定にする
                for otherButton in buttons where otherButton != redButton {
                    otherButton.backgroundColor = .white
                    otherButton.tintColor = .black
                }
                // blueButtonが選択されている場合
            } else if button == blueButton && blueButtonSelected {
                button.backgroundColor = .black
                button.tintColor = .white
                
                // blueButton以外をデフォルトの設定にする
                for otherButton in buttons where otherButton != blueButton {
                    otherButton.backgroundColor = .white
                    otherButton.tintColor = .black
                }
                //greenButtonが選択されている場合
            } else if button == greenButton && greenButtonSelected {
                button.backgroundColor = .black
                button.tintColor = .white
                
                // greenButton以外をデフォルトの設定にする
                for otherButton in buttons where otherButton != greenButton {
                    otherButton.backgroundColor = .white
                    otherButton.tintColor = .black
                }
                //yellowButtonが選択されている場合
            } else if button == yellowButton && yellowButtonSelected {
                button.backgroundColor = .black
                button.tintColor = .white
                
                //yellowButton以外をデフォルトの設定にする
                for otherButton in buttons where otherButton != yellowButton {
                    otherButton.backgroundColor = .white
                    otherButton.tintColor = .black
                }
                //whiteButtonが選択されている場合
            } else if button == whiteButton && whiteButtonSelected {
                button.backgroundColor = .black
                button.tintColor = .white
                
                //whiteButton以外をデフォルトの設定にする
                for otherButton in buttons where otherButton != whiteButton {
                    otherButton.backgroundColor = .white
                    otherButton.tintColor = .black
                }
                //blackButtonが選択されている場合
            } else if button == blackButton && blackButtonSelected {
                button.backgroundColor = .black
                button.tintColor = .white
                
                //blackButton以外をデフォルトの設定にする
                for otherButton in buttons where otherButton != blackButton {
                    otherButton.backgroundColor = .white
                    otherButton.tintColor = .black
                }
            }
        }
    }
    //カラーごとの画像取得API
    private func fetchPhotos(for color: String) {
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
                let photos = response.results.map { photo in
                               return photo
                           }
                           DispatchQueue.main.async {
                               self?.photos = photos
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let spacingBetweenItems: CGFloat = 10
        
        if indexPath.item == 0 {
            // 一枚目のセルは全幅
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
    
    let CollectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.minimumInteritemSpacing = 10
      layout.minimumLineSpacing = 10
      layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
      layout.sectionInsetReference = .fromSafeArea
      let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
      collectionView.backgroundColor = .white
      collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "ColorCell")
      return collectionView
  }()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)  // 左右の余白を統一
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    //日付の設定
    func formatDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: dateString) else { return dateString }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "yyyy年MM月dd日"
        
        return displayFormatter.string(from: date)
    }
    //Segueの設定
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
           let updatedAt = photoDict["updated_at"] as? String
        {
            
            destinationVC.selectedImage = selectedImage
            destinationVC.wallPaperColor = wallPaperColor
            destinationVC.name = name
            destinationVC.username = username
            destinationVC.location = location
            destinationVC.authorURL = (userDict["links"] as? [String: Any])?["html"] as? String
            destinationVC.updatedAt = formatDate(updatedAt)
        }
    }
}
