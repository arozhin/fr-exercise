//
//  ImageService.swift
//  fetchrewardtest
//
//  Image downloading and caching service for thumbnails
//

import Foundation
import UIKit

class ImageCache {
    var cache = NSCache<NSString,UIImage>()

    init(limit:Int) {
        cache.countLimit = limit
    }

    func image(_ url:String) -> UIImage? {
        return cache.object(forKey: NSString(string:url))
    }

    func saveImage(_ uiImage:UIImage, url:String) {
        cache.setObject(uiImage, forKey: NSString(string: url))
    }
}

extension UIImageView {
    func imageFromURL(_ urlString: String) {
        self.image = nil
        if let cached = imageCache().image(urlString) {
            self.image = cached
        }

        if let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let newImage = UIImage(data: data) {
                            self.imageCache().saveImage(newImage, url: urlString)
                            self.image = newImage
                        }
                    }
                }
            }
            task.resume()
        }
    }

    func imageCache() -> ImageCache {
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.core.imageCache
    }
}
