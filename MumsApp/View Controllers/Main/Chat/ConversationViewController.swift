import UIKit
import MessageKit
import MapKit

class ConversationViewController: MessagesViewController {
    
    var messageList: [Message] = [] {
        didSet {
            DispatchQueue.main.async {
                self.messagesCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()

        self.configureNavigationBar()

        self.getData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainRootVC?.hideButtons()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        mainRootVC?.showButtons()
        
    }
    
    private func configureView() {
        
        self.view.setBackground()

        self.messagesCollectionView.backgroundColor = .clear
        
        self.messagesCollectionView.messagesDataSource = self
        
        self.messagesCollectionView.messagesLayoutDelegate = self
        
        self.messagesCollectionView.messagesDisplayDelegate = self
        
        self.messagesCollectionView.messageCellDelegate = self
        
        self.messageInputBar.delegate = self
        
        self.messageInputBar.sendButton.tintColor = .mainGreen
        
        self.scrollsToBottomOnFirstLayout = true //default false
        
        self.scrollsToBottomOnKeybordBeginsEditing = true // default false
        
        self.defaultStyle()
        
    }

    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "User name")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
        let detailsButton = UIBarButtonItem(title: "Details", style: .plain, target: self, action: #selector(self.detailsButtonPressed(sender:)))
        
        detailsButton.tintColor = .mainGreen
        
        self.navigationItem.rightBarButtonItem = detailsButton

    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func detailsButtonPressed(sender: UIBarButtonItem) {
        
        self.showOrganisationViewController()
        
    }
    
    private func showOrganisationViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.organisationViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    private func getData() {
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            SampleData.shared.getMessages(count: 10) { messages in
                
                DispatchQueue.main.async {
                
                    self.messageList = messages
            
                }
        
            }
        
        }
        
    }

    // MARK: - Keyboard Style
    
    func defaultStyle() {
        
        self.messageInputBar = MessageInputBar()
        
        self.messageInputBar.sendButton.tintColor = .mainGreen
        
        self.messageInputBar.delegate = self

        self.reloadInputViews()
        
        self.messageInputBar.isTranslucent = false
        
        self.messageInputBar.separatorLine.isHidden = true
        
        self.messageInputBar.inputTextView.backgroundColor = .backgroundWhite
        
        self.messageInputBar.inputTextView.placeholderTextColor = .mainDarkGrey
        
        self.messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 36)
        
        self.messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 36)
        
        self.messageInputBar.inputTextView.layer.borderColor = UIColor.clear.cgColor
        
        self.messageInputBar.inputTextView.layer.borderWidth = 0
        
        self.messageInputBar.inputTextView.layer.cornerRadius = 16.0
        
        self.messageInputBar.inputTextView.layer.masksToBounds = true
        
        self.messageInputBar.inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        
        self.messageInputBar.setRightStackViewWidthConstant(to: 36, animated: true)
        
        self.messageInputBar.setStackViewItems([messageInputBar.sendButton], forStack: .right, animated: true)
       
        self.messageInputBar.sendButton.imageView?.backgroundColor = UIColor(red: 190/255, green: 196/255, blue: 214/255, alpha: 1)
        
        self.messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        
        self.messageInputBar.sendButton.setSize(CGSize(width: 36, height: 36), animated: true)
        
        self.messageInputBar.sendButton.image = #imageLiteral(resourceName: "arrowUp")
        
        self.messageInputBar.sendButton.title = nil
        
        self.messageInputBar.sendButton.imageView?.layer.cornerRadius = 16
        
        self.messageInputBar.sendButton.backgroundColor = .clear
        
        self.messageInputBar.textViewPadding.right = -38
        
    }
    
}

// MARK: - MessagesDataSource

extension ConversationViewController: MessagesDataSource {
    
    func currentSender() -> Sender {
    
        return SampleData.shared.currentSender
    
    }
    
    func numberOfMessages(in messagesCollectionView: MessagesCollectionView) -> Int {
    
        return self.messageList.count
   
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return self.messageList[indexPath.section]
    
    }
    
    func avatar(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> Avatar {
    
        return SampleData.shared.getAvatarFor(sender: message.sender)
    
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
     
//        let name = message.sender.displayName
        
//        let attributes = [NSFontAttributeName : UIFont.regular(size: 13),
//                          NSForegroundColorAttributeName : UIColor.mainDarkGrey]
        
        return nil
    
    }
    
    func cellBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = .medium
        
        let dateString = formatter.string(from: message.sentDate)
        
        let attributes = [NSFontAttributeName : UIFont.regular(size: 13),
                          NSForegroundColorAttributeName : UIColor.mainDarkGrey]
        
        return NSAttributedString(string: dateString, attributes: attributes)

    }
    
}

// MARK: - MessagesDisplayDelegate

extension ConversationViewController: MessagesDisplayDelegate, TextMessageDisplayDelegate {
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        
        return isFromCurrentSender(message: message) ? .mainGreen : .containerGreyColor
    
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
       
        return isFromCurrentSender(message: message) ? .white : .black
    
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        
        return .bubbleTail(corner, .curved)
    
    }
    
}

// MARK: - MessagesLayoutDelegate

extension ConversationViewController: MessagesLayoutDelegate {
    
    func messagePadding(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIEdgeInsets {
        
        if isFromCurrentSender(message: message) {
        
            return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 4)
        
        } else {
        
            return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 30)
        
        }
    
    }
    
    func cellTopLabelAlignment(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LabelAlignment {
      
        if isFromCurrentSender(message: message) {
        
            return .messageTrailing(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10))
        
        } else {
        
            return .messageLeading(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        
        }
    
    }
    
    func cellBottomLabelAlignment(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LabelAlignment {
       
        if isFromCurrentSender(message: message) {
        
            return .messageLeading(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        
        } else {
        
            return .messageTrailing(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10))
        
        }
    
    }
    
    func avatarAlignment(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> AvatarAlignment {
       
        return .messageBottom
    
    }
    
    func footerViewSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        
        return CGSize(width: messagesCollectionView.bounds.width, height: 10)
   
    }
    
}

// MARK: - LocationMessageLayoutDelegate

extension ConversationViewController: LocationMessageLayoutDelegate {
    
    func heightForLocation(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
      
        return 200
    
    }
    
}

// MARK: - MediaMessageLayoutDelegate

extension ConversationViewController: MediaMessageLayoutDelegate {}

// MARK: - MessageCellDelegate

extension ConversationViewController: MessageCellDelegate {
    
    func didTapAvatar<T>(in cell: MessageCollectionViewCell<T>) {
        print("Avatar tapped")
    }
    
    func didTapMessage<T>(in cell: MessageCollectionViewCell<T>) {
        print("Message tapped")
    }
    
}

// MARK: - MessageLabelDelegate

extension ConversationViewController: MessageLabelDelegate {
    
    func didSelectAddress(_ addressComponents: [String : String]) {
        print("Address Selected: \(addressComponents)")
    }
    
    func didSelectDate(_ date: Date) {
        print("Date Selected: \(date)")
    }
    
    func didSelectPhoneNumber(_ phoneNumber: String) {
        print("Phone Number Selected: \(phoneNumber)")
    }
    
    func didSelectURL(_ url: URL) {
        print("URL Selected: \(url)")
    }
    
}

// MARK: - LocationMessageDisplayDelegate

extension ConversationViewController: LocationMessageDisplayDelegate {
    
    func annotationViewForLocation(message: MessageType, at indexPath: IndexPath, in messageCollectionView: MessagesCollectionView) -> MKAnnotationView? {
      
        let annotationView = MKAnnotationView(annotation: nil, reuseIdentifier: nil)
        
        let pinImage = #imageLiteral(resourceName: "pin")
        
        annotationView.image = pinImage
        
        annotationView.centerOffset = CGPoint(x: 0, y: -pinImage.size.height / 2)
        
        return annotationView
    
    }
    
    func animationBlockForLocation(message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> ((UIImageView) -> Void)? {
       
        return { view in
        
            view.layer.transform = CATransform3DMakeScale(0, 0, 0)
            
            view.alpha = 0.0
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [], animations: {
                view.layer.transform = CATransform3DIdentity
                view.alpha = 1.0
            }, completion: nil)
        
        }
        
    }
    
}

// MARK: - MessageInputBarDelegate

extension ConversationViewController: MessageInputBarDelegate {
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
       
        self.messageList.append(Message(text: text, sender: currentSender(), messageId: UUID().uuidString, date: Date()))
        
        inputBar.inputTextView.text = String()
        
        self.messagesCollectionView.reloadData()
        
        self.messagesCollectionView.scrollToBottom()
    
    }
    
}

