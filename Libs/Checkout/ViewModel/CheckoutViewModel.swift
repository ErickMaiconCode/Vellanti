import Foundation
import Combine

class CheckoutViewModel: ObservableObject {
    
    @Published var street: String = ""
    @Published var number: String = ""
    @Published var neighborhood: String = ""
    @Published var city: String = ""
    @Published var zipCode: String = ""

    @Published var selectedMethod: PaymentMethod = .creditCard
    @Published var cardNumber: String = ""
    @Published var cardHolder: String = ""
    @Published var cardExpiry: String = ""
    @Published var cardCVV: String = ""
    
    var isValid: Bool {
        let addressValid = !street.isEmpty && !number.isEmpty && !city.isEmpty
        
        if selectedMethod == .pix {
            return addressValid
        } else {
            return addressValid && !cardNumber.isEmpty && !cardHolder.isEmpty && !cardExpiry.isEmpty && !cardCVV.isEmpty
        }
    }
    
    var fullAddress: String {
        "\(street), \(number)\n\(neighborhood) - \(city)\nCEP: \(zipCode)"
    }
    
    var paymentMethodDescription: String {
        if selectedMethod == .pix {
            return "Pagamento instantâneo via Pix"
        } else {
            let last4 = cardNumber.suffix(4)
            return "Cartão final \(last4.isEmpty ? "****" : last4)"
        }
    }
}
