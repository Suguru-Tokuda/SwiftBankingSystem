import Foundation

public struct CustomerModel : Customer {
    public var firstName: String
    public var lastName: String
    public var accounts: [Account]
    private var accountDict: [Int : Account] = [:]
    
    public init(firstName: String, lastName: String, accounts: [Account]) {
        self.firstName = firstName
        self.lastName = lastName
        self.accounts = accounts
    }
    
    /**
     Get an accout for an account number
     */
    public func getAccount(_ accountNumber: Int) -> Account? {
        return AccountService.shared.accountDict[accountNumber]
    }
    
    /**
     Return an array of string as accout names
     */
    public func listAllAccounts() -> [String] {
        var retVal = accounts.map { $0.accountType.rawValue }
        
        print("\(firstName) \(lastName)'s Account list (\(retVal.count)):")
        
        accounts.forEach { account in
            print("- \(account.accountType.rawValue) (Account#: \(account.accountNumber) Balance: \(account.balance.toCurrencyStr()))")
        }
        
        // Sort by name
        retVal.sort(by: { $0 > $1 })
        
        return retVal
    }
    
    /**
     Return a string representative of the total ammount.
     */
    public func getTotalBankBalance() -> String {
        let retVal = accounts.reduce(0) { $0 + $1.balance }
        print("\(firstName) \(lastName)'s total balance: \(retVal.toCurrencyStr())")
        return retVal.toCurrencyStr()
    }
    
    
    public func transferFunds(transferAmount: Double, from accountNumFrom: Int, to accountNumTo: Int) throws {
        if var fromAccount = AccountService.shared.accountDict[accountNumFrom],
           var toAccount = AccountService.shared.accountDict[accountNumTo] {
            try performTransferFunds(transferAmount: transferAmount, from: &fromAccount, to: &toAccount)
        }
    }
    
    /**
        Transfer funds from one to another.
        The function uses Generic for Account type
     */
    private func performTransferFunds<T: Account>(transferAmount: Double, from accountToGetFundFrom: inout T, to accountToTransferFundTo: inout T) throws -> Void {
        if accountToGetFundFrom.balance > 0 {
            if transferAmount > 0 && accountToGetFundFrom.isValidTransaction(amount: transferAmount) {
                accountToGetFundFrom.balance -= transferAmount
                accountToTransferFundTo.balance += transferAmount
                print("Successfully transfered \(transferAmount.toCurrencyStr()) from \(accountToGetFundFrom.accountType.rawValue) to \(accountToTransferFundTo.accountType.rawValue)")
            }
        } else {
            throw BankingAccountError.insufficientBalanceError(balance: accountToGetFundFrom.balance, amount: transferAmount)
        }
    }
    
    // mutating func to add account. mutating keyword is required for struct.
    public mutating func addAccount(account: Account) -> Bool {
        var accountExists = false
        
        self.accounts.forEach { existingAccount in if existingAccount.accountNumber == account.accountNumber { accountExists = true }}
        
        if !accountExists {
            self.accounts.append(account)
            // add to dictionary
            AccountService.shared.accountDict[account.accountNumber] = account
        }
        
        return !accountExists
    }
    
    // add multiple accounts by using Generic.
    public mutating func addAccounts<T: Account>(accounts: Array<T>) -> Int {
        var retVal = 0
        
        for i in 0..<accounts.count {
            if addAccount(account: accounts[i]) { retVal += 1 }
        }
        
        return retVal
    }
}
