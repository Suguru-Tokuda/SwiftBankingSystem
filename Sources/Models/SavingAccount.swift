import Foundation

class SavingAccount : Account {
    var interestRate: Float
    var minimumBalance: Double
    
    // Failable initilizer
    init?(accountNumber: Int, initialBalance: Double, interestRate: Float, minimumBalance: Double) {
        self.interestRate = interestRate
        self.minimumBalance = minimumBalance
        
        if minimumBalance > initialBalance {
            return nil
        }
        
        super.init(accountNumber: accountNumber, initialBalance: initialBalance, accountType: .saving)
    }
    
    override func withdraw(amount: Double) -> Double {
        if isValidTransaction(amount: amount) {
            balance -= amount
        }
        return balance
    }

    // Calculate interest and add to the balance
    func calculateInterest() -> Double {
        if self.balance > 0 {
            let interest = self.balance * Double(interestRate)
            print("Interest: \(interest.toCurrencyStr())")
            self.balance += interest
            return self.balance
        } else {
            return self.balance
        }
    }
    
    // public function to check if a transaction is valid.
    override func isValidTransaction(amount: Double) -> Bool {
        do {
            return try performIsValidTransaction(amount: amount)
        } catch let error {
            print(error)
            return false
        }
    }
    
    // private func which performs the check for valid transations.
    private func performIsValidTransaction(amount: Double) throws -> Bool {
        let balanceAfterTransaction = self.balance - amount
        
        if balanceAfterTransaction < self.minimumBalance {
            throw BankingAccountError.minimumBalanceError(balance: balanceAfterTransaction, minimumBalance: self.minimumBalance)
        }
        
        return true
    }
}
