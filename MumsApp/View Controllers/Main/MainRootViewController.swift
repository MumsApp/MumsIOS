import UIKit

class MainRootViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    fileprivate var menuWindow: UIWindow?
    
    fileprivate var menuController: UIViewController?
    
    fileprivate var menuButton: UIButton!

    private let transition = BubbleTransition()
    
    private var displayed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addMenuButton()

        self.configureNavigationBar()
        
        self.transition.duration = 0.3
        
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
        
        self.transition.startingPoint = self.menuWindow!.center
        
        self.transition.bubbleColor = UIColor.white.withAlphaComponent(0.95)
        
        return self.transition
  
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.transition.transitionMode = .dismiss
        
        self.transition.startingPoint = self.menuWindow!.center
        
        self.transition.bubbleColor = UIColor.white.withAlphaComponent(0.95)
        
        return self.transition
        
    }
    
    private func addMenuButton() {
        
        if let mainWindow = UIApplication.shared.keyWindow {
            
            let size: CGFloat = 75
            
            let y = mainWindow.frame.maxY - size + 25
            
            let backgroundFrame = CGRect(x: mainWindow.frame.midX - size / 2, y: y, width: size, height: size)
             
            self.menuController = UIViewController()
            
            self.menuController!.view.frame = backgroundFrame
            
            self.menuController!.view.backgroundColor = .clear
            
            self.menuButton = UIButton(type: .custom)
            self.menuButton.frame = CGRect(x: 0, y: 0, width: size, height: size)
            self.menuButton.backgroundColor = .white
            self.menuButton.setTitle("", for: UIControlState.normal)
            self.menuButton.setImage(#imageLiteral(resourceName: "menuIcon"), for: .normal)
            self.menuButton.addTarget(self, action: #selector(self.menuButtonPressed), for: UIControlEvents.touchUpInside)
            self.menuButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
            
            self.menuButton.addShadow()
            
            self.menuController!.view.addSubview(self.menuButton!)
            
            self.menuButton.layer.cornerRadius = size / 2

            self.menuWindow = UIWindow(frame: backgroundFrame)
            
            self.menuWindow!.backgroundColor = .clear
            
            self.menuWindow!.rootViewController = self.menuController
            
            self.menuWindow!.windowLevel = UIWindowLevelStatusBar
            
            self.menuWindow!.isHidden = false
            
        }
            
    }
    
    func removeMenuButton() {
        
        self.menuButton.removeFromSuperview()
        
        self.menuController?.removeFromParentViewController()
        
        self.menuWindow?.removeFromSuperview()
        
    }
    
}

extension MainRootViewController: MenuDelegate {
    
    func lobbyButtonPressed() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.lobbyViewController()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        self.navigationController?.pushViewController(controller, animated: false)
        
        self.menuButtonPressed()

    }
    
    func profileButtonPressed() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.profileViewController()
        
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
