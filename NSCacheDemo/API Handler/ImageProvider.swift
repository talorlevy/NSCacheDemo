//
//  ImageProvider.swift
//  JsonDataExample
//
//  Created by Talor Levy on 2/11/23.
//

import UIKit

class ImageProvider {
    
    static let shared = ImageProvider()
    private init() {}
    private let cache = NSCache<NSString, UIImage>()
    
    public func fetchImage(stringToImage: String, completion: @escaping (UIImage?) -> Void) {
        if let image = cache.object(forKey: stringToImage as NSString) {
            print("using cache")
            completion(image)
            return
        }
        guard let url = URL(string: stringToImage) else {
            completion(nil)
            return
        }
        print("Fetching image")
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                self?.cache.setObject(image, forKey: stringToImage as NSString)
                completion(image)
            }
        }.resume()
    }
}
