import Foundation
import ReachabilitySwift

enum ReachabilityType {
    
    case timeout, closed
    
}

class MOReachability {
    
    static let shared = Reachability()
    
}

extension UIViewController {
    
    func isReachable() -> Bool {
        
        let reachability = MOReachability.shared
        
        return reachability!.isReachable
        
    }
    
}
