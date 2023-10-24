import Foundation

// Enum for credit card type
public enum CreditCardType: Double {
    // each credit card type has initial transaction fee rate
    case visa = 0.1,
         masterCard = 0.2,
         discover = 0.3,
         americanExpress = 0.4
    
    // get transaction fee for the amount of purchse.
    func getTransactionFee(amount: Double) -> Double {
        switch self {
        case .visa:
            if amount < 100 {
                return amount * self.rawValue
            } else if amount >= 100 { // add discount for a large ammount
                return amount * (self.rawValue - 0.01)
            }
        case .masterCard:
            if amount < 1000 {
                return amount * self.rawValue
            } else if amount >= 1000 {
                return amount * (self.rawValue - 0.01)
            }
        case .discover:
            if amount < 1500 {
                return amount * self.rawValue
            } else if amount >= 1500 {
                return amount * (self.rawValue - 0.01)
            }
        case .americanExpress:
            if amount < 2000 {
                return amount * self.rawValue
            } else if amount >= 2000 {
                return amount * (self.rawValue - 0.01)
            }
        }
        
        return 0.0
    }
}
