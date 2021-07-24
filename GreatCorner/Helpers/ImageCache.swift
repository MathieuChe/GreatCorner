//
//  ImageCache.swift
//  GreatCorner
//
//  Created by Mathieu Chelim on 24/07/2021.
//

import UIKit


//MARK:- Class

final class ImageCache {
    
    private let lock: NSLock = NSLock()
    
    private let imagesCountLimit: Int = 300
    
    // 1024 is for 1k-octet Object and 300 imagesCountLimit
    private let imagesTotalCostLimit: Int = 1024 * 300
    
    // Set the cache to hold image and its string
    private lazy var cache: NSCache<NSString, UIImage> = {
        
        // NSCache is a memory cache means every restart NSCache is not persistent
        let cache = NSCache<NSString, UIImage>()
        
        // The maximum number of objects the cache should hold.
        cache.countLimit = imagesCountLimit
        // The maximum total cost that the cache can hold before it starts evicting objects.
        cache.totalCostLimit = imagesTotalCostLimit
        return cache
    }()
    
    // MARK: Store and Retrieve image in/from cache
    func storeImageInCache(_ image: UIImage, for url: URL) {
        // defer is used for executing lock.unlock() after lock.lock() so used when opening and closing context in this scope
        lock.lock(); defer { lock.unlock() }
        cache.setObject(image, forKey: url.absoluteString as NSString)
    }
    
    func retrieveImageFromCache(with url: URL) -> UIImage? {
        lock.lock(); defer { lock.unlock() }
        return cache.object(forKey: url.absoluteString as NSString)
    }
}
