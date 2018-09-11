import Foundation

let SHOP_CATEGORY_URL = BASE_URL + "shop/category"

struct ShopCategoryService: ResourceService {
    
    let serviceName = "ShopCategoriesService"
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser
    
    let type: ShopViewType
    
    private func configureURL(url: String) -> String {
        
        let text = type == .shop ? "shop" : "service"
        
        let configuredURL = url.replacingOccurrences(of: "shop", with: text)
        
        return configuredURL
        
    }
    
    // MARK: - Get Shop categories
    
    func getShopCategories(token: String, completion: @escaping JSONResponseCompletion) {
        
        let urlToConfigure = self.configureURL(url: SHOP_CATEGORY_URL)

        if var request = URLRequest.GETRequest(urlString: urlToConfigure) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .data, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
}
