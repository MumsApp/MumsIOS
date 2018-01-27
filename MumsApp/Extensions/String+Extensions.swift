import Foundation

extension String {
    
    /// Used to check if string is an email
    func isEmail() -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let email = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return email.evaluate(with: self)
        
    }
    
    /// Used to trim white spaces from string
    func trim() -> String {
        
        return trimmingCharacters(in: .whitespacesAndNewlines)
        
    }
    
}
