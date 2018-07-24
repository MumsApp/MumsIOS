import Foundation

let SHOP_CATEGORY_URL = BASE_URL + "shop/category"

struct ShopCategoryService: ResourceService {
    
    let serviceName = "ShopCategoriesService"
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser
    
    // MARK: - Get Shop categories
    
    func getShopCategories(token: String, completion: @escaping JSONResponseCompletion) {
        
        if var request = URLRequest.GETRequest(urlString: SHOP_CATEGORY_URL) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(tag: 0, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
}
