//
//  ImageService.swift
//  Volunteer
//
//  Created by William Ordaz on 2/21/21.
//

import Foundation
import UIKit

class ImageService {
    
     static let cache = NSCache<NSString, UIImage>()
       
    static func downloadImage(withURL url:URL, completion: @escaping (_ image:UIImage?, _ url:URL)->()) {
           let dataTask = URLSession.shared.dataTask(with: url) { data, responseURL, error in
               
               var downloadedImage:UIImage?
               
               if let data = data {
                   downloadedImage = UIImage(data: data)
               }
               
               if downloadedImage != nil {
                   cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
               }
               
               DispatchQueue.main.async {
                   completion(downloadedImage, url)

               }
           }
           dataTask.resume()
       }
       
    static func getImage(withURL url:URL, completion: @escaping (_ image:UIImage?, _ url:URL)->()) {
           if let image = cache.object(forKey: url.absoluteString as NSString) {
               completion(image, url)
           } else {
               downloadImage(withURL: url, completion: completion)
           }
       }
}
