import Foundation

public class SavingAccount : Account {
    var interestRate: Float
    var minimumBalance: Double
    
    public init(accountNumber: Int, initialBalance: Double, interestRate: Float, minimumBalance: Double) {
        self.interestRate = interestRate
        self.minimumBalance = minimumBalance
        super.init(accountNumber: accountNumber, initialBalance: initialBalance, accountType: .saving)
    }
    
    public func calculateInterest() -> Double {
        if self.balance > 0 {
            let interest = self.balance * Double(interestRate)
            print("Interest: \(interest.toCurrencyStr())")
            self.balance += interest
            return self.balance
        } else {
            return self.balance
        }
    }
    
    public override func isValidTransaction(amount: Double) -> Bool {
        do {
            return try performIsValidTransaction(amount: amount)
        } catch let error {
            print(error)
            return false
        }
    }
    
    private func performIsValidTransaction(amount: Double) throws -> Bool {
        let balanceAfterTransaction = self.balance - amount
        
        if balanceAfterTransaction < self.minimumBalance {
            throw BankingAccountError.minimumBalanceError(balance: balanceAfterTransaction, minimumBalance: self.minimumBalance)
        }
        
        return true
    }
}
