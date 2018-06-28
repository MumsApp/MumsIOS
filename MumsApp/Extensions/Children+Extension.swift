import Foundation

extension Children {
    
    func formatter() -> String {
        
        var title = ""
        
        guard let sex = self.sex, let ageUnit = self.ageUnit, let age = self.age else { return title }
        
        
        //        Child sex
        //        1 - male
        //        2 - female
        //        3 - to come
        
        //        Child age unit
        //        1 - weeks
        //        2 - months
        //        3 - years
        
        switch sex {
            
        case 1:
            
            title += "Girl " + String(age)
            
        case 2:
            
            title += "Boy " + String(age)
            
        case 3:
            
            title += "To come " + String(age)
            
        default:
            
            break
            
        }
        
        switch ageUnit {
            
        case 1:
            
            title += age == 1 ? " week old" : " weeks old"
            
        case 2:
            
            title += age == 1 ? " month old" : " months old"
            
        case 3:
            
            title += age == 1 ? " year old" : " years old"
            
        default:
            
            break
            
        }
        
        return title
        
    }
    
}
