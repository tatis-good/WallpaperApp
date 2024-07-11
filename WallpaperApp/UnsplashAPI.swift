import Foundation

//func fetchRandomPhotos(completion: @escaping ([UnsplashPhoto]?) -> Void) {
//     let accessKey = "cwcyr_9_PKVl7r8428TGviniDw9af6e2WLp2AjKXahY"
//     guard let url = URL(string: "https://api.unsplash.com/photos/?per_page=5&order_by=latest&client_id=\(accessKey)") else {
//         completion(nil)
//         return
//     }
//     
//     let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//         if let error = error {
//             print("Error: \(error.localizedDescription)")
//             completion(nil)
//             return
//         }
//         
//         guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//             print("Server responded with an error")
//             completion(nil)
//             return
//         }
//         
//         guard let data = data else {
//             print("No data received")
//             completion(nil)
//             return
//         }
//         
//         do {
//             let photos = try JSONDecoder().decode([UnsplashPhoto].self, from: data)
//             completion(photos)
//         } catch {
//             print("Error decoding JSON: \(error.localizedDescription)")
//             completion(nil)
//         }
//     }
//     
//     task.resume()
// }
  


