//
//  NetworkManager.swift
//  AlfagiftTakeHome
//
//  Created by Rizky Maulana on 26/02/23.
//
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
    let cache = NSCache<NSString, UIImage>()
    private var isImageDownloading = false
    private var imageCallback: ((UIImage?)->Void)?
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func getPopularMovies(page value: Int, completion: @escaping(MovieResponse)-> Void) {
        let endpoint = MovieBaseURL.baseURL + "trending/movie/day" + MovieBaseURL.apiKey + "&page=\(value)"
        guard let URL = URL(string: endpoint) else {
            print("URL Invalid")
            return
        }
        
        let task = URLSession.shared.dataTask(with: URL) { data, response, error in
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
            
            do {
                let movies = try self.decoder.decode(MovieResponse.self, from: data)
                completion(movies)
                
            } catch {
                print("Failed to fetch Movie List.")
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: ((UIImage?)-> Void)?) {
        let combinedString = MovieBaseURL.imageURL + urlString
        let cacheKey = NSString(string: combinedString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed?(image)
            return
        }
        
        print(isImageDownloading)
        
        guard !isImageDownloading else {
            self.imageCallback = completed
            return
        }
        
        isImageDownloading = true
        
        guard let url = URL(string: combinedString) else {
            print("Invalid URL.")
            return
        }
        
        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
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
                completed?(nil)
                return
            }
            DispatchQueue.main.async {
                self.imageCallback?(image)
                self.imageCallback = nil
                self.cache.setObject(image, forKey: cacheKey)
                completed?(image)
                self.isImageDownloading = false
            }
            
        }
        task.resume()
    }
    
    func getMovieDetail(with id: Int,and requests:[MovieRequest], completed: @escaping (MovieDetail)-> Void) {
        var requestArray: [String] = []
        for i in requests {
            requestArray.append(i.rawValue)
        }
        let joinedRequest = requestArray.joined(separator: ",")
        let endpoint = MovieBaseURL.baseURL + MovieBaseURL.movie + String(id) + MovieBaseURL.apiKey + MovieBaseURL.appendToResponse + joinedRequest
        
        guard let url = URL(string: endpoint) else {
            print("Invalid URL.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                print("Unable to complete your request. Please check your internet connection.")
                return
            }
            
            print(url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Invalid response from the server. Please try again.")
                return
            }
            
            guard let data = data else {
                print("The data recieved from the server was invalid. Please try again.")
                return
            }
            
            do {
                let movies = try self.decoder.decode(MovieDetail.self, from: data)
                completed(movies)
                
            } catch {
                print("Failed to fetch Movie List.")
            }
        }
        task.resume()
    }
    
}


