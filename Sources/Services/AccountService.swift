import Foundation

/**
    Service class which holds static variable
 */
public class AccountService {
    public static let shared = AccountService()
    public var accountDict: [Int : Account] = [:]
    
    public init() {}
    
    public func getTotalBalance() -> Double {
        let retVal = accountDict.reduce(0) { $0 + $1.value.balance }
        print("Total balance in the bank for all customer accounts: \(retVal.toCurrencyStr())")
        return retVal
    }
}
