import Foundation

public class BusinessAccount : Account {
    public override init(accountNumber: Int, initialBalance: Double, accountType: AccountType = .business) {
        super.init(accountNumber: accountNumber, initialBalance: initialBalance, accountType: accountType)
    }
    
    public func acceptCreditCardPayment(transactionContent: String, transactionAmmount: Double, creditCardType: CreditCardType) -> Double {
        do {
            return try performAcceptCreditCardPayment(transactionContent: transactionContent, transactionAmount: transactionAmmount, creditCardType: creditCardType)
        } catch let err {
            print(err)
        }
        
        return self.balance
    }
    
    private func performAcceptCreditCardPayment(transactionContent: String, transactionAmount: Double, creditCardType: CreditCardType) throws -> Double {
        if transactionAmount > 0 {
            let transactionFee = creditCardType.getTransactionFee(amount: transactionAmount)
            
            if self.balance > transactionFee {
                self.balance += transactionAmount - transactionFee
                print("Transaction completed: \(transactionContent) - ")
                print("Transaction amount: \(transactionAmount.toCurrencyStr())")
                print("Transaction fee: \(transactionFee.toCurrencyStr())")
                print("Total profit from the transaction: \((transactionAmount - transactionFee).toCurrencyStr())")
            } else {
                throw BankingAccountError.insufficientBalanceError(balance: self.balance, amount: transactionAmount)
            }
        }
        
        return self.balance
    }
    
    public override func isValidTransaction(amount: Double) -> Bool {
        return true
    }
}
