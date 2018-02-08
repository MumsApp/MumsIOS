import Foundation

let k_question = "question"
let k_answer = "answer"
let k_terms = "terms"

struct Terms: Resource {
    
    static let typeName = "Terms"
    
    var question: String?
    
    var answer: String?
    
    init(dictionary: StorableDictionary) {
        
        self.question = dictionary[k_question] as? String
        
        self.answer = dictionary[k_answer] as? String
        
    }
    
    static func fromDictionary(dictionary: Dictionary<String, Any>) -> Terms {
        
        let resource = Terms(dictionary: dictionary)
        
        return resource
        
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        
        var dictionary = Dictionary<String, Any>()
        
        dictionary[k_question] = self.question
        
        dictionary[k_answer] = self.answer
        
        return dictionary
        
    }
    
}
