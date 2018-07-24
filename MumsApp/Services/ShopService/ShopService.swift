import Foundation
import UIKit

let ADD_SHOP_PRODUCT_URL = BASE_URL + "shop/product?name={name}&description={description}&price={price}&category={category}&lat={lat}&lon={lon}"

let k_price = "price"
let k_category = "category"

struct ShopService: ResourceService {
    
    let serviceName = "ShopService"
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser
    
    // MARK: - Add shop product
    
    func addShopProduct(name: String, description: String, price: String, category: String, token: String, lat: String, lon: String, images: [UIImage], completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_name: name, k_description: description, k_price: price, k_category: category, k_lat: lat, k_lon: lon]
        
        let url = ADD_SHOP_PRODUCT_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.POSTRequestData(urlString: url) {

            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .data, completion: completion)
            
            let task = DataUploadJsonResponseTask(urlRequest: request, name: "file", fileName: "file.jpg", mimeType: "image/jpg", taskCompletion: response)
       
            var array: Array<Data> = []
            
            for image in images {
                
                let imageDataOptional = UIImageJPEGRepresentation(image, 0.1)

                array.append(imageDataOptional!)
                
            }
            
            _ = self.networkService.enqueueNetworkMultipleUploadRequest(request: task, multipleData: array)
            
        }
        
    }
    
}
