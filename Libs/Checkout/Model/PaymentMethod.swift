import Foundation

enum PaymentMethod: String, CaseIterable, Identifiable {
    case creditCard = "Cartão de Crédito"
    case pix = "PIX"
    
    var id: String { self.rawValue }
    var icon: String {
        switch self {
        case .creditCard:
            return "creditcard"
        case .pix:
            return "qrcode"
        }
    }
}
