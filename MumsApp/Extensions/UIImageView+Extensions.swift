import Foundation
import UIKit

extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    
}

typealias ImageCacheLoaderCompletionHandler = ((UIImage) -> ())

class ImageCacheLoader {
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<NSString, UIImage>!
    
    init() {
        
        session = URLSession.shared
    
        task = URLSessionDownloadTask()
        
        self.cache = NSCache()
    
    }
    
    func obtainImageWithPath(imagePath: String, completionHandler: @escaping ImageCacheLoaderCompletionHandler) {
       
        if let image = self.cache.object(forKey: imagePath as NSString) {
        
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
                    
                    self.cache.setObject(img, forKey: imagePath as NSString)
                    
                    DispatchQueue.main.async {
                    
                        completionHandler(img)
                    
                    }
                    
                }
                
            })
            
            task.resume()
        
        }
    }
}
