import Foundation

protocol Customer {
    var firstName: String { get set }
    var lastName: String { get set }
    var accounts: [Account] { get set }
    
    func listAllAccounts() -> [String]
    func getTotalBankBalance() -> String
    func transferFunds(transferAmount: Double, from accountNumFrom: Int, to accountNumTo: Int) throws -> Void
    mutating func addAccount(account: Account) -> Bool
}
