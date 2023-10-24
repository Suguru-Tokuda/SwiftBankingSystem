import Foundation

// giving extra feature to Double type
extension Double {
    /**
     Converts a number into a currency String.
     i.g 1000 will be "$1000.00"
     */
    public func toCurrencyStr() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        let formattedNumber = numberFormatter.string(from: NSNumber(value: self))
        
        guard let number = formattedNumber else { return "$0.00" }
        
        return "$\(number)"
    }
}
