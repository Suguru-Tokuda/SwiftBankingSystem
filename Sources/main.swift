import Foundation

public func main() {
    print("This is Swift Banking Online System. Please create a new account with the new customer information.")

    var customer1 = CustomerModel(firstName: "Suguru", lastName: "Tokuda", accounts: [])
    var customer2 = CustomerModel(firstName: "Tim", lastName: "Cook", accounts: [])

    print("Please select account types you would like to create.")

    // initialize new accounts for customer 1
    let checkingAccount = CheckingAccount(accountNumber: 12345, initialBalance: 1_000)
    let savingAccount = SavingAccount(accountNumber: 12346, initialBalance: 1_500, interestRate: 0.1, minimumBalance: 500)
    let businessAccount = BusinessAccount(accountNumber: 12347, initialBalance: 200_000)

    let checkingAccount2 = CheckingAccount(accountNumber: 22345, initialBalance: 1_000_000)

    // add to customer accounts
    var accounts: [Account] = []
    accounts.append(checkingAccount)
    _ = customer1.addAccount(account: checkingAccount)
    // unwrap optional
    if let savingAccount {
        accounts.append(savingAccount)
    }
    accounts.append(businessAccount)

    _ = customer1.addAccounts(accounts: accounts)
    _ = customer2.addAccount(account: checkingAccount2)

    print("")
    print("New accounts are successfully create.")

    _ = customer1.listAllAccounts()
    _ = AccountService.shared.getTotalBalance()

    print("")
    _ = customer2.listAllAccounts()
    _ = AccountService.shared.getTotalBalance()

    // deposit & withdraw
    if let checkingAccount: CheckingAccount = customer1.getAccount(12345) as? CheckingAccount {
        _ = checkingAccount.deposit(amount: 500)
        _ = checkingAccount.withdraw(amount: 500)
        
        // error handling
        _ = checkingAccount.withdraw(amount: 1_000_000)
    }

    print("")
    // transfer funds
    customer1.transferFunds(transferAmount: 500, from: 12345, to: 22345)
    _ = customer1.listAllAccounts()
    print("")
    _ = customer2.listAllAccounts()

    print("")
    // get interest for saving account
    if let savingAccount: SavingAccount = customer1.getAccount(12346) as? SavingAccount {
        _ = savingAccount.calculateInterest()
        _ = customer1.listAllAccounts()
        _ = AccountService.shared.getTotalBalance()
    }

    print("")
    // for business account, create a credit card transaction (extra feature)
    if let businessAccount: BusinessAccount = customer1.getAccount(12347) as? BusinessAccount {
        _ = businessAccount.acceptCreditCardPayment(transactionContent: "A Macbook Pro was sold", transactionAmmount: 3500, creditCardType: .masterCard)
        _ = customer1.listAllAccounts()
        _ = AccountService.shared.getTotalBalance()
    }
}
