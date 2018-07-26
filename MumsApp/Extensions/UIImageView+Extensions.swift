import Foundation
import UIKit

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
