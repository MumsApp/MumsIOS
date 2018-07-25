import UIKit

class VerticallyButton: UIButton {
    
    var padding: CGFloat = 8.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        
        if let titleSize = titleLabel?.sizeThatFits(maxSize), let imageSize = imageView?.sizeThatFits(maxSize) {
            let width = ceil(max(imageSize.width, titleSize.width))
            let height = ceil(imageSize.height + titleSize.height + padding)
            
            return CGSize(width: width, height: height)
        }
        
        return super.intrinsicContentSize
    }
    
    override func layoutSubviews() {
        if let image = imageView?.image, let title = titleLabel?.attributedText {
            let imageSize = image.size
            let titleSize = title.size()
            
            titleEdgeInsets = UIEdgeInsetsMake(-(imageSize.height + padding), -imageSize.width, 0.0, 0.0)
            imageEdgeInsets = UIEdgeInsetsMake(0, 0.0, -(titleSize.height + padding), -titleSize.width)
        
        }
        
        super.layoutSubviews()
    }
    
}

class VerticallyTopButton: UIButton {
    
    var padding: CGFloat = 20.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        
        if let titleSize = titleLabel?.sizeThatFits(maxSize), let imageSize = imageView?.sizeThatFits(maxSize) {
            let width = ceil(max(imageSize.width, titleSize.width))
            let height = ceil(imageSize.height + titleSize.height + padding)
            
            return CGSize(width: width, height: height)
        }
        
        return super.intrinsicContentSize
    }
    
    override func layoutSubviews() {
        
        titleLabel?.numberOfLines = 0
        
        if let image = imageView?.image, let title = titleLabel?.attributedText {
            let imageSize = image.size
            let titleSize = title.size()
            
            titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + padding), 0.0)
            imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + padding), 0.0, 0.0, -titleSize.width)
        }
        
        super.layoutSubviews()
    }
    
}

