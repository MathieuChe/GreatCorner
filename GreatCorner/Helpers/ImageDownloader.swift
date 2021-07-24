//
//  ImageDownloader.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import UIKit

final class ImageDownloader {
    
    // Create a singleton
    static var shared = ImageDownloader()
    
    private static let successCodeRange = 200..<300
    
    static func download(from url: URL, completion: @escaping (UIImage?, HTTPError?) -> Void) -> URLSessionTask? {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // HTTP request will always respond with a response of type HTTPURLResponse
            let httpResponse = response as? HTTPURLResponse
            
            // Check if request failed
            if let error = error, let httpResponse = httpResponse {
                if !ImageDownloader.successCodeRange.contains(httpResponse.statusCode) {
                    completion(nil, HTTPError.fromHTTPURLResponse(httpResponse))
                } else {
                    completion(nil, HTTPError.fromNSError(error as NSError))
                }
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil, .noData)
                return
            }
            
            completion(image, nil)
        }
        
        task.resume()
        
        return task
    }
}
