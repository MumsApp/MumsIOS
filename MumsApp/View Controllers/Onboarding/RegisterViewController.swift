import UIKit

class RegisterViewController: UIViewController {

    private var registerService: RegisterService!
    
    private var loginService: LoginService!
    
    func configureWith(registerService: RegisterService, loginService: LoginService) {
        
        self.registerService = registerService
        
        self.loginService = loginService
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.login()
        
    }

    private func register() {
        
        self.registerService.register(email: "john@smith.com", password: "qqqq") { errorOptional in
            
            if let error = errorOptional {
                
                print(error)
                
            } else {
                
                print("Success")
                
            }
            
        }

    }
    
    private func login() {
        
        self.loginService.login(email: "john@smith.com", password: "qqqq") { errorOptional in
            
            if let error = errorOptional {
                
                print(error)
                
            } else {
                
                print("Success")
                
            }
            
        }
        
    }
    
}
