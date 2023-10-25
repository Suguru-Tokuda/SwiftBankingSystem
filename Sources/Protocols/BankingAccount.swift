import Foundation

protocol BankingAccount {
    var accountNumber: Int { get set }
    var balance: Double { get set }
    var accountType: AccountType { get set }
    
    // deposit and return the total balance
    func deposit(amount: Double) -> Double
    // withdraw and return the total balance
    func withdraw(amount: Double) -> Double
    func isValidTransaction(amount: Double) -> Bool
}
/*
    Implements default behaviors of functions.
 */
extension BankingAccount {
    mutating func deposit(amount: Double) -> Double {
        if amount > 0 {
            balance += amount
        }
        
        return balance
    }
    
    mutating func withdraw(amount: Double) -> Double {
        if balance >= amount {
            balance -= amount
        }
        
        return balance
    }
    
    func isValidTransaction(amount: Double) -> Bool {
        return true
    }
}
