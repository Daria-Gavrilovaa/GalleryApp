//
//  Networking.swift
//  GalleryApp
//
//  Created by MAC on 07.09.25.
//

import Foundation

enum Link {
    case images(page: Int, limit: Int)
    
    var url: URL {
        switch self {
        case .images(let page, let limit):
            return URL(string: "https://api.unsplash.com/photos?page=\(page)&per_page=\(limit)")!
        }
    }
}

final class NetworkManager: ObservableObject {
    
    init() {}
    
    static let shared = NetworkManager()
    
    var images = [Photo]()
    private var token = "ttjV4npqziwmjqehd1Ibx3KVUgFWCA7eNxotJwfTOwQ"
    
    func fetchPhoto(page: Int = 1, limit: Int = 30, completion: @escaping ([Photo]) -> ()) {
        var request = URLRequest(url: Link.images(page: page, limit: limit).url)
        
        request.httpMethod = "GET"
        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data, error == nil else { return }
            
            let httpsResponse = response as? HTTPURLResponse
            print("Status code: \(String(describing: httpsResponse?.statusCode))")
            
            do {
                let images = try JSONDecoder().decode([Photo].self, from: data)
                DispatchQueue.main.async {
                    completion(images)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
