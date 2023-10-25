import Foundation

enum BankingAccountError : Error {
    case insufficientDepositAmountError(amount: Double),
         insufficientBalanceError(balance: Double, amount: Double),
         minimumBalanceError(balance: Double, minimumBalance: Double)
}

extension BankingAccountError : LocalizedError {
    var errorDescription: String? {
        var retVal: String?
        switch self {
        case .insufficientBalanceError(balance: let balance, amount: let amount):
            if balance < amount {
                retVal = "The transaction cannot be completed, because he withdraw amount (\(amount.toCurrencyStr()) exceeds the balance (\(balance.toCurrencyStr()). Please try again."
            }
            
        case .insufficientDepositAmountError(amount: let amount):
            if amount < 0 {
                retVal = "The deposit amount \(amount.toCurrencyStr()) needs to be a positive."
            }
        case .minimumBalanceError(balance: let balance, minimumBalance: let minimumBalance):
            if balance < minimumBalance {
                retVal = "The balance (\(balance)) needs to exceed (\(minimumBalance))"
            }
        }
        
        return retVal
    }
}
