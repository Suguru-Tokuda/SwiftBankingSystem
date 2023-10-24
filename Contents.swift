import Foundation

print("This is Swift Banking Online System. Please create a new account with the new customer information.")

var customer1 = CustomerModel(firstName: "Suguru", lastName: "Tokuda", accounts: [])
var customer2 = CustomerModel(firstName: "Tim", lastName: "Cook", accounts: [])

print("Please select account types you would like to create.")

// initialize new accounts for customer 1
let checkingAccount = CheckingAccount(accountNumber: 12345, initialBalance: 1000)
let savingAccount = SavingAccount(accountNumber: 12346, initialBalance: 1500, interestRate: 0.1, minimumBalance: 500)
let businessAccount = BusinessAccount(accountNumber: 12347, initialBalance: 200000)

let checkingAccount2 = CheckingAccount(accountNumber: 22345, initialBalance: 100000000)

// add to
customer1.addAccount(account: checkingAccount)
// unwrap optional
if let savingAccount {
    customer1.addAccount(account: savingAccount)
}
customer1.addAccount(account: businessAccount)

customer2.addAccount(account: checkingAccount2)

print("")
print("New accounts are successfully create.")

customer1.listAllAccounts()
AccountService.shared.getTotalBalance()

print("")
customer2.listAllAccounts()
AccountService.shared.getTotalBalance()

// deposit & withdraw
if var checkingAccount: CheckingAccount = customer1.getAccount(12345) as? CheckingAccount {
    checkingAccount.deposit(amount: 500)
    checkingAccount.withdraw(amount: 500)
    
    // error handling
    checkingAccount.withdraw(amount: 1000000)
}

print("")
// transfer funds
customer1.transferFunds(transferAmount: 500, from: 12345, to: 22345)
customer1.listAllAccounts()
print("")
customer2.listAllAccounts()

print("")
// get interest for saving account
if let savingAccount: SavingAccount = customer1.getAccount(12346) as? SavingAccount {
    savingAccount.calculateInterest()
    customer1.listAllAccounts()
    AccountService.shared.getTotalBalance()
}

print("")
// for business account, create a credit card transaction (extra feature)
if let businessAccount: BusinessAccount = customer1.getAccount(12347) as? BusinessAccount {
    businessAccount.acceptCreditCardPayment(transactionContent: "A Macbook Pro was sold", transactionAmmount: 3500, creditCardType: .masterCard)
    customer1.listAllAccounts()
    AccountService.shared.getTotalBalance()
}

