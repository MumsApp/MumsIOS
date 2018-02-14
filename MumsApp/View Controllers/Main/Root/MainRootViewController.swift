import UIKit

enum ControllerType {
    
    case lobby
    case chat
    case profile
    case shop
    
}

var mainRootVC: MainRootViewController?

class MainRootViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var menuButton: UIButton!

    private let transition = BubbleTransition()
    
    private var displayed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addMenuButton()

        self.configureNavigationBar()
        
        self.transition.duration = 0.3
        
        mainRootVC = self
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.displayed == false {
            
            self.menuButtonPressed()

            self.displayed = true
            
        }
        
    }
    
    private func configureNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let controller = segue.destination as? MenuViewController
        
        controller?.transitioningDelegate = self
        
        controller?.modalPresentationStyle = .custom
        
        controller?.configureWith(delegate: self)
        
    }
    
    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
        self.transition.transitionMode = .present
        
        self.transition.startingPoint = self.menuButton.center
        
        self.transition.bubbleColor = UIColor.white.withAlphaComponent(0.95)
        
        return self.transition
  
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.transition.transitionMode = .dismiss
        
        self.transition.startingPoint = self.menuButton.center
        
        self.transition.bubbleColor = UIColor.white.withAlphaComponent(0.95)
        
        return self.transition
        
    }
    
    private func addMenuButton() {
        
        if let window = UIApplication.shared.keyWindow {

            let size: CGFloat = 75
            
            self.menuButton = UIButton(type: .custom)
            
            self.menuButton.frame = CGRect(x: window.frame.midX - size / 2, y: window.frame.maxY - size + 25, width: size, height: size)
            
            self.menuButton.backgroundColor = .white
            
            self.menuButton.setTitle("", for: UIControlState.normal)
            
            self.menuButton.setImage(#imageLiteral(resourceName: "menuIcon"), for: .normal)
            
            self.menuButton.addTarget(self, action: #selector(self.menuButtonPressed), for: UIControlEvents.touchUpInside)
            
            self.menuButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
            
            self.menuButton.addShadow()
            
            self.menuButton.layer.cornerRadius = size / 2
            
            window.addSubview(self.menuButton)
            
        }
      
    }
    
    func removeMenuButton() {
        
        self.menuButton = nil
        
    }
    
}

extension MainRootViewController: MenuDelegate {
    
    func lobbyButtonPressed() {
    
        self.showViewController(type: .lobby)
        
    }
    
    func profileButtonPressed() {
        
        self.showViewController(type: .profile)

    }
    
    func chatButtonPressed() {
        
        self.showViewController(type: .chat)

    }
    
    func shopButtonPressed() {
    
        self.showViewController(type: .shop)
    
    }
    
    func showViewController(type: ControllerType) {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()

        let controller: UIViewController!
        
        switch type {
            
        case .chat:
            
            controller = factory.chatViewController()
            
        case .lobby:
            
            controller = factory.lobbyViewController()
            
        case .profile:
            
            controller = factory.profileViewController()
            
        case .shop:
            
            controller = factory.shopViewController()
            
        }
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationController?.pushViewController(controller, animated: false)
        
        self.menuButtonPressed()
        
    }
    
    func menuButtonPressed() {
        
        if self.menuButton.tag == 0 {
            
            self.menuButton.tag = 1
            
            UIView.transition(with: self.menuButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
                
                self.menuButton.setImage(#imageLiteral(resourceName: "closeIcon"), for: .normal)
                
            }, completion: nil)
            
            self.performSegue(withIdentifier: "MenuSegue", sender: self)
            
        } else {
            
            self.menuButton.tag = 0
            
            UIView.transition(with: self.menuButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
                
                self.menuButton.setImage(#imageLiteral(resourceName: "menuIcon"), for: .normal)
                
            }, completion: nil)
            
            self.dismissViewController()
            
        }
        
    }
    
}
