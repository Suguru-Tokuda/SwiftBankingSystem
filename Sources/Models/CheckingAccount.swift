import Foundation

public class CheckingAccount : Account {
    override public init(accountNumber: Int, initialBalance: Double, accountType: AccountType = .checking) {
        super.init(accountNumber: accountNumber, initialBalance: initialBalance, accountType: .checking)
    }
    
    public override func isValidTransaction(amount: Double) -> Bool {
        do {
            return try performIsValidTransaction(amount: amount)
        } catch let error {
            print(error.localizedDescription)
            return false
        }
    }
    
    private func performIsValidTransaction(amount: Double) throws -> Bool {
        if self.balance < amount {
            throw BankingAccountError.insufficientBalanceError(balance: self.balance, amount: amount)
        }
        
        return true
    }
}
