import Foundation
import SwiftUI

struct PhoneFormatter {
    static func format(phone: String, countryCode: String) -> String {
        let digitsOnly = phone.filter { $0.isNumber }
        
        switch countryCode {
        case "+55": return formatBrazilianPhone(digitsOnly)
        case "+1": return formatUSPhone(digitsOnly)
        default: return formatGenericPhone(digitsOnly)
        }
    }
    
    private static func formatBrazilianPhone(_ digits: String) -> String {
        guard !digits.isEmpty else { return "" }
        let maxLength = 11
        let cleaned = String(digits.prefix(maxLength))
        var formatted = ""
        for (index, char) in cleaned.enumerated() {
            if index == 0 { formatted += "(" }
            else if index == 2 { formatted += ") " }
            else if index == 7 && cleaned.count == 11 { formatted += "-" }
            else if index == 6 && cleaned.count == 10 { formatted += "-" }
            formatted.append(char)
        }
        return formatted
    }
    
    private static func formatUSPhone(_ digits: String) -> String {
        guard !digits.isEmpty else { return "" }
        let maxLength = 10
        let cleaned = String(digits.prefix(maxLength))
        var formatted = ""
        for (index, char) in cleaned.enumerated() {
            if index == 0 { formatted += "(" }
            else if index == 3 { formatted += ") " }
            else if index == 6 { formatted += "-" }
            formatted.append(char)
        }
        return formatted
    }
    
    private static func formatGenericPhone(_ digits: String) -> String {
        return String(digits.prefix(15))
    }
}

extension Binding where Value == String {
    func phoneFormatted(countryCode: String) -> Binding<String> {
        Binding<String>(
            get: { self.wrappedValue },
            set: { newValue in
                let digitsOnly = newValue.filter { $0.isNumber }
                self.wrappedValue = PhoneFormatter.format(phone: digitsOnly, countryCode: countryCode)
            }
        )
    }
}
