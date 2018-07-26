import Foundation
import UIKit
import Kingfisher

class LoadableImageView: UIImageView {
    
    func loadImage(urlStringOptional: String?) {
        
        self.image = nil

        if let urlString = urlStringOptional, let url = URL(string: BASE_PUBLIC_IMAGE_URL + urlString) {
         
            self.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholderImage"))

        } else {
            
            self.image = #imageLiteral(resourceName: "placeholderImage")

        }
        
    }
    
}

let cache = NSCache<NSString, UIImage>()

typealias ImageCacheLoaderCompletionHandler = ((UIImage) -> ())

class ImageCacheLoader {

    var task: URLSessionDownloadTask!
    var session: URLSession!

    init() {

        session = URLSession.shared

        task = URLSessionDownloadTask()

    }

    func obtainImageWithPath(imagePath: String, completionHandler: @escaping ImageCacheLoaderCompletionHandler) {

        if let image = cache.object(forKey: imagePath as NSString) {

            DispatchQueue.main.async {

                completionHandler(image)

            }

        } else {

            let placeholder = #imageLiteral(resourceName: "placeholderImage")

            DispatchQueue.main.async {

                completionHandler(placeholder)

            }

            let url: URL! = URL(string: imagePath)

            task = session.downloadTask(with: url, completionHandler: { (location, response, error) in

                if let data = try? Data(contentsOf: url) {

                    let img: UIImage! = UIImage(data: data)

                    cache.setObject(img, forKey: imagePath as NSString)

                    DispatchQueue.main.async {

                        completionHandler(img)

                    }

                }

            })

            task.resume()

        }
    }

}
