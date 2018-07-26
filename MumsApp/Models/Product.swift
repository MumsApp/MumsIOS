import Foundation
import UIKit

let k_categoryName = "categoryName"
let k_creatorName = "creatorName"
let k_creatorPhoto = "creatorPhoto"
let k_photos = "photos"
let k_creatorId = "creatorId"
let k_pointName = "pointName"
let k_isUserFavourite = "isUserFavourite"

struct Product: Resource {
    
    static let typeName = "Product"
    
    var id: Int?
    
    var name: String?
    
    var description: String?
    
    var price: String?
    
    var lat: String?
    
    var lon: String?
    
    var pointName: String?
    
    var category: Int?
    
    var categoryName: String?
    
    var creatorName: String?
    
    var creatorId: Int?
    
    var creatorPhoto: String?
    
    var creationDate: Int?
    
    var isUserFavourite: Bool?
    
    var photos: Array<Photo>?
        
    init(dictionary: StorableDictionary) {
        
        self.id = dictionary[k_id] as? Int
                
        self.name = dictionary[k_name] as? String
        
        self.description = dictionary[k_description] as? String
        
        self.price = dictionary[k_price] as? String
        
        self.lat = dictionary[k_lat] as? String
        
        self.lon = dictionary[k_lon] as? String
        
        self.pointName = dictionary[k_pointName] as? String
        
        self.category = dictionary[k_category] as? Int
        
        self.categoryName = dictionary[k_categoryName] as? String
    
        self.creatorName = dictionary[k_creatorName] as? String
        
        self.creatorId = dictionary[k_creatorId] as? Int
        
        self.creatorPhoto = dictionary[k_creatorPhoto] as? String
    
        self.creationDate = dictionary[k_creationDate] as? Int
        
        self.isUserFavourite = dictionary[k_isUserFavourite] as? Bool
        
        if let photosArray = dictionary[k_photos] as? Array<Dictionary<String, Any>> {
            
            self.photos = []
            
            for photoDictionary in photosArray {
                
                self.photos?.append(Photo.fromDictionary(dictionary: photoDictionary))
                
            }
            
        }
        
    }
    
    static func fromDictionary(dictionary: Dictionary<String, Any>) -> Product {
        
        let resource = Product(dictionary: dictionary)
        
        return resource
        
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        
        var dictionary = Dictionary<String, Any>()
        
        dictionary[k_id] = self.id
        
        dictionary[k_name] = self.name
        
        dictionary[k_description] = self.description
        
        dictionary[k_price] = self.price
        
        dictionary[k_lat] = self.lat
        
        dictionary[k_lon] = self.lon
        
        dictionary[k_pointName] = self.pointName
        
        dictionary[k_category] = self.category
        
        dictionary[k_categoryName] = self.categoryName
        
        dictionary[k_creatorName] = self.creatorName
        
        dictionary[k_creatorId] = self.creatorId
        
        dictionary[k_creatorPhoto] = self.creatorPhoto
        
        dictionary[k_creationDate] = self.creationDate
        
        dictionary[k_isUserFavourite] = self.isUserFavourite
        
        var photosArray: Array<Dictionary<String, Any>> = []
        
        for photo in self.photos! {
            
            photosArray.append(photo.toDictionary())
            
        }
        
        dictionary[k_photos] = photosArray
        
        return dictionary
        
    }
    
}
