import Foundation
import UIKit

let ADD_SHOP_PRODUCTS_URL = BASE_URL + "shop/product?name={name}&description={description}&price={price}&category={category}&lat={lat}&lon={lon}&pointName={pointName}"
let UPDATE_SHOP_PRODUCT_URL = BASE_URL + "shop/product/{id}?name={name}&description={description}&price={price}&category={category}&lat={lat}&lon={lon}&pointName={pointName}"
let USER_SHOP_PRODUCTS_URL = BASE_URL + "shop/product/my"
let SHOP_PRODUCTS_URL = BASE_URL + "shop/product/paginated/{page}/" + PAGINATION
let SHOP_FAVOURITE_PRODUCTS_URL = BASE_URL + "shop/product/favourite"
let SHOP_ADD_FAVOURITE_URL = BASE_URL + "shop/product/{id}/favourite"
let SHOP_SEARCH_URL = BASE_URL + "shop/product/search/{page}/" + PAGINATION

let k_price = "price"
let k_category = "category"
let k_products = "products"
let k_priceFrom = "priceFrom"
let k_priceTo = "priceTo"
let k_userLat = "userLat"
let k_userLon = "userLon"
let k_distanceFrom = "distanceFrom"
let k_distanceTo = "distanceTo"

struct ShopService: ResourceService {
    
    let serviceName = "ShopService"
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser
    
    // MARK: - Add shop product
    
    func addShopProduct(name: String, description: String, price: String, category: String, token: String, lat: String, lon: String, pointName: String, images: [UIImage], completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_name: name, k_description: description, k_price: price, k_category: category, k_lat: lat, k_lon: lon, k_pointName: pointName]
        
        let url = ADD_SHOP_PRODUCTS_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.POSTRequestData(urlString: url) {

            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .status, completion: completion)
            
            let task = DataUploadJsonResponseTask(urlRequest: request, name: "file", fileName: "file.jpg", mimeType: "image/jpg", taskCompletion: response)
       
            var array: Array<Data> = []
            
            for image in images {
                
                let imageDataOptional = UIImageJPEGRepresentation(image, 0.1)

                array.append(imageDataOptional!)
                
            }
            
            _ = self.networkService.enqueueNetworkMultipleUploadRequest(request: task, multipleData: array)
            
        }
        
    }
    
    // MARK: - Update shop product
    
    func updateShopProduct(id: String, name: String, description: String, price: String, category: String, token: String, lat: String, lon: String, pointName: String, images: [UIImage], completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_id: id, k_name: name, k_description: description, k_price: price, k_category: category, k_lat: lat, k_lon: lon, k_pointName: pointName]
        
        let url = UPDATE_SHOP_PRODUCT_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.PUTRequestData(urlString: url, bodyData: nil) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .status, completion: completion)
            
            let task = DataUploadJsonResponseTask(urlRequest: request, name: "file", fileName: "file.jpg", mimeType: "image/jpg", taskCompletion: response)
            
            var array: Array<Data> = []
            
            for image in images {
                
                let imageDataOptional = UIImageJPEGRepresentation(image, 0.1)
                
                array.append(imageDataOptional!)
                
            }
            
            _ = self.networkService.enqueueNetworkMultipleUploadRequest(request: task, multipleData: array)
            
        }
        
    }
    
    // MARK: - Get user shop products

    func getUserShopProducts(token: String, completion: @escaping JSONResponseCompletion) {
        
        if var request = URLRequest.GETRequest(urlString: USER_SHOP_PRODUCTS_URL) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .data, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - Get shop products
 
    func getShopProducts(token: String, page: Int, completion: @escaping JSONResponseCompletion) {
        
        let pathParameters = [k_page: String(page)]
        
        let url = SHOP_PRODUCTS_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.GETRequest(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .data, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - Get user favourite shop products
    
    func getUserFavouriteShopProducts(token: String, completion: @escaping JSONResponseCompletion) {
        
        if var request = URLRequest.GETRequest(urlString: SHOP_FAVOURITE_PRODUCTS_URL) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .data, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - Add favourite shop product
    
    func addFavouriteProduct(id: String, token: String, completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_id: id]
        
        let url = SHOP_ADD_FAVOURITE_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.POSTRequestData(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .status, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - Remove favourite shop product
    
    func removeFavouriteProduct(id: String, token: String, completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_id: id]
        
        let url = SHOP_ADD_FAVOURITE_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.DELETERequest(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .status, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }

    // MARK: - Search shop products with pagination
    
    func searchShopProducts(searchTerm: String, page: Int, token: String, completion: @escaping JSONResponseCompletion) {
        
        let pathParameters = [k_page: String(page)]
        
        let bodyParameters = [k_searchTerm: searchTerm]
        
        let url = SHOP_SEARCH_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.GETRequest(urlString: url, bodyParameters: bodyParameters) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .data, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - Search shop products with pagination and filters
    
    func searchShopProducts(page: Int, bodyParameters: Dictionary<String, Any>, token: String, completion: @escaping JSONResponseCompletion) {
        
        let pathParameters = [k_page: String(page)]
        
        let url = SHOP_SEARCH_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.GETRequest(urlString: url, bodyParameters: bodyParameters) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .data, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }

}
