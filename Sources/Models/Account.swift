import Foundation

public class Account : BankingAccount, ValidTransaction {
    public var accountNumber: Int
    public var balance: Double
    public var accountType: AccountType
    
    public init(accountNumber: Int, initialBalance: Double, accountType: AccountType) {
        self.accountNumber = accountNumber
        self.balance = initialBalance
        self.accountType = accountType
    }
    
    public func deposit(amount: Double) -> Double {
        do {
            return try performDeposit(amount: amount)
        } catch let err {
            print(err)
            return self.balance
        }
    }
    
    private func performDeposit(amount: Double) throws -> Double {
        if amount > 0 {
            self.balance += amount
            return self.balance
        } else {
            throw BankingAccountError.insufficientDepositAmountError(amount: amount)
        }
    }
    
    public func withdraw(amount: Double) -> Double {
        do {
            return try performWithdraw(amount: amount)
        } catch let err {
            print(err)
            return self.balance
        }
    }
    
    private func performWithdraw(amount: Double) throws -> Double {
        if self.balance >= amount {
            self.balance -= amount
            return self.balance
        } else {
            throw BankingAccountError.insufficientBalanceError(balance: self.balance, amount: amount)
        }
    }
    
    public func isValidTransaction(amount: Double) -> Bool {
        return true
    }
}
