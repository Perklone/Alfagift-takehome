//
//  CustomImageView.swift
//  AlfagiftTakeHome
//
//  Created by Rizky Maulana on 27/02/23.
//

import UIKit

class CustomImageView: UIImageView {
    var imageTask: URLSessionDataTask!
    func downloadImage(from urlString: String) {
        let combinedString = MovieBaseURL.imageURL + urlString
        let cacheKey = NSString(string: combinedString)
        
        if let image = NetworkManager.shared.cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        if let imageTask = imageTask {
            imageTask.cancel()
        }
        guard let url = URL(string: combinedString) else {
            print("Invalid URL.")
            return
        }
        
        imageTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                print("Unable to complete your request. Please check your internet connection.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Invalid response from the server. Please try again.")
                return
            }
            
            guard let data = data else {
                print("The data recieved from the server was invalid. Please try again.")
                return
            }
            guard let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                NetworkManager.shared.cache.setObject(image, forKey: cacheKey)
                self.image = image
            }
            
        }
        imageTask.resume()
    }
}
