import Foundation

public protocol ValidTransaction {
    func isValidTransaction(amount: Double) -> Bool
}
