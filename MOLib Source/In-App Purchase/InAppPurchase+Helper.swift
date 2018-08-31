import Foundation
import StoreKit

public typealias ProductIdentifier = String

public typealias ProductsRequestCompletionHandler = (_ products: [SKProduct]?) -> ()

let k_has_finished = "has_finished"

open class InAppPurchaseHelper : NSObject  {
    
    static let PurchaseNotification = Notification.Name("PurchaseNotification")
    
    fileprivate let productIdentifiers: Set<ProductIdentifier>
    
    fileprivate var purchasedProductIdentifiers = Set<ProductIdentifier>()
    
    fileprivate var productsRequest: SKProductsRequest?
    
    fileprivate var productsRequestCompletionHandler: ProductsRequestCompletionHandler?
    
    fileprivate var skPaymentQueue: SKPaymentQueue!
    
    override init() {
        
        self.productIdentifiers = Products.productIdentifiers
        
        self.skPaymentQueue = SKPaymentQueue.default()
        
        super.init()
                
        self.skPaymentQueue.add(self)
        
    }
    
    deinit {
        
        self.skPaymentQueue.remove(self)
        
    }
    
    public func requestProducts(completionHandler: @escaping ProductsRequestCompletionHandler) {
        
        self.productsRequestCompletionHandler = completionHandler
        
        if self.canMakePayments() {
            
            self.productsRequest?.cancel()
            
            self.productsRequest = SKProductsRequest(productIdentifiers: self.productIdentifiers)
            
            self.productsRequest?.delegate = self
            
            self.productsRequest?.start()
            
        } else {
            
            self.productsRequestCompletionHandler?(nil)
            
        }
        
    }
    
    public func buyProduct(_ product: SKProduct) {
        
        print("Buying \(product.productIdentifier)...")
        
        let payment = SKPayment(product: product)
        
        self.skPaymentQueue.add(payment)
        
    }
    
    private func canMakePayments() -> Bool {
        
        return SKPaymentQueue.canMakePayments()
        
    }
    
}

extension InAppPurchaseHelper: SKProductsRequestDelegate {
    
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        print("Loaded list of products...")
        
        print("Invalid: \(response.invalidProductIdentifiers)")
        
        print("Valid: \(response.products)")
        
        let products = response.products
        
        self.productsRequestCompletionHandler?(products)
        
        self.clearRequestAndHandler()
        
        for p in products {
            
            print("Found product: \(p.productIdentifier) \(p.localizedTitle) \(p.price.floatValue)")
            
        }
        
    }
    
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        
        print("Failed to load list of products.")
        
        print("Error: \(error.localizedDescription)")
        
        self.productsRequestCompletionHandler?(nil)
        
        self.clearRequestAndHandler()
        
    }
    
    private func clearRequestAndHandler() {
        
        self.productsRequest = nil
        
        self.productsRequestCompletionHandler = nil
        
    }
    
}

extension InAppPurchaseHelper: SKPaymentTransactionObserver {
    
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            switch transaction.transactionState {
                
            case .purchased:
                
                self.complete(transaction: transaction)
                
                break
                
            case .failed:
                
                self.fail(transaction: transaction)
                
                break
          
            case .restored: break
            case .deferred: break
            case .purchasing: break
                
            }
            
        }
        
    }
    
    private func complete(transaction: SKPaymentTransaction) {
        
        print("complete...")
        
        self.deliverPurchaseNotificationFor(identifier: transaction.payment.productIdentifier)
        
        self.skPaymentQueue.finishTransaction(transaction)
        
    }
    
    private func fail(transaction: SKPaymentTransaction) {
        
        print("fail...")
        
        if let transactionError = transaction.error {
            
            if transactionError._code != SKError.paymentCancelled.rawValue {
                
                print("Transaction Error: \(transactionError.localizedDescription)")
                
            }
            
        }
        
        self.skPaymentQueue.finishTransaction(transaction)
        
        NotificationCenter.default.post(name: InAppPurchaseHelper.PurchaseNotification, object: nil, userInfo: [k_has_finished: false])
        
    }
    
    private func deliverPurchaseNotificationFor(identifier: String?) {
        
        guard let identifier = identifier else { return }
        
        self.purchasedProductIdentifiers.insert(identifier)
        
        NotificationCenter.default.post(name: InAppPurchaseHelper.PurchaseNotification, object: identifier, userInfo: [k_has_finished: true])
        
    }
    
}
