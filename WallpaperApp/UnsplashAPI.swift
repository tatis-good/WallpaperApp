//
//  UnsplashAPI.swift
//  WallpaperApp
//
//  Created by spark-02 on 2024/07/02.
//

import Foundation

func fetchUnsplashPhoto(completion: @escaping (UnsplashPhoto?) -> Void) {
    let apiKey = "cwcyr_9_PKVl7r8428TGviniDw9af6e2WLp2AjKXahY"
    let urlString = "https://api.unsplash.com/photos/random"
    guard let url = URL(string: urlString) else { return }
    
    var request = URLRequest(url: url)
    request.setValue("Client-ID \(apiKey)", forHTTPHeaderField: "Authorization")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            completion(nil)
            return
        }
        
        do {
            let photo = try JSONDecoder().decode(UnsplashPhoto.self, from: data)
            completion(photo)
        } catch {
            completion(nil)
        }
    }
    
    task.resume()
}

