
import UIKit



class ColorSearchViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var photos: [UnsplashPhoto] = []
    let AccessKey = "cwcyr_9_PKVl7r8428TGviniDw9af6e2WLp2AjKXahY"
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @IBAction func redButton(_ sender: UIButton) {
        fetchPhotos(for: "red")
    }
    
    @IBAction func blueButton(_ sender: UIButton) {
        fetchPhotos(for: "blue")
    }
    
    @IBAction func greenButton(_ sender: UIButton) {
        fetchPhotos(for: "green")
    }
    
    @IBAction func yellowButton(_ sender: UIButton) {
        fetchPhotos(for: "yellow")
    }
    
    @IBAction func whiteButton(_ sender: UIButton) {
        fetchPhotos(for: "white")
    }
    
    @IBAction func blackButton(_ sender: UIButton) {
        fetchPhotos(for: "black")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhotoDetail" {
            if let destinationVC = segue.destination as? SegueViewController, let photo = sender as? UnsplashPhoto {
                destinationVC.selectedImage = getImage(from: photo.urls.regular)
            }
        }
    }
    
    func getImage(from urlString: String) -> UIImage? {
        guard let url = URL(string: urlString), let data = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: data)
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
}
