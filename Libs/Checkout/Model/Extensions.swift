import Foundation

extension Double {
    var toCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(floatLiteral: self)) ?? "R$ 0.00"
    }
}
