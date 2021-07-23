//
//  HTTPService.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 23/07/2021.
//

import Foundation

// Set NetworkCompletion typealias

typealias NetworkCompletion<T: Decodable> = (Result<T, Error>) -> Void

//MARK:- protocol

protocol Network {
    func sendRequest<T: Decodable>(_ request: Request, completion: @escaping NetworkCompletion<T>)
}

//MARK:- Class

final class HTTPService: Network {
    
    //MARK:- Property

    // Success Status Code
    private static let successCodeRange = 200..<300
    
    //MARK:- API JSON Decode Service
    
    // T for the Model Decodable
    func sendRequest<T: Decodable>(_ httpRequest: Request, completion: @escaping NetworkCompletion<T>) {
        
        guard let httpRequest = httpRequest as? HTTPRequest else {
            completion(.failure(HTTPError.badRequest))
            return
        }
        
        var urlRequest: URLRequest
                
        // try URLRequest could throw an error then try do-catch
        do {
            
            guard let url = httpRequest.resourceUrl else { throw HTTPError.badRequest }
            urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-type")
            
        } catch let nsError as NSError {
            return completion(.failure(HTTPError.fromNSError(nsError)))
        }

        // URLSession singleton to coordinate task to retreive data
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
             
            // HTTP request will always respond with a response of type HTTPURLResponse
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            // Check if request failed
            if let error = error {
                
                if HTTPService.successCodeRange.contains(httpResponse.statusCode) {
                    completion(.failure(HTTPError.fromNSError(error as NSError)))
                } else {
                    completion(.failure(HTTPError.fromHTTPURLResponse(httpResponse)))
                }
                return
            }
            
            // Check if data exist
            guard let data = data else {
                completion(.failure(HTTPError.noData))
                return
            }
            
            // Decode json to object
            let jsonDecoder = JSONDecoder()
            
            do {
                let itemOrCategoryObject = try jsonDecoder.decode(T.self, from: data)
                completion(.success(itemOrCategoryObject))
            } catch {
                completion(.failure(HTTPError.decodingError))
            }
        }
        
        task.resume()
    }
}
