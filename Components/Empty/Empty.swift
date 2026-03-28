import SwiftUI

enum EmptyStateType {
    case cart
    case orders
    case wishlist
    case generic(icon: String, title: String, message: String)
    
    var icon: String {
        switch self {
        case .cart:
            return "bag"
        case .orders:
            return "shippingbox"
        case .wishlist:
            return "heart"
        case .generic(let icon, _, _):
            return icon
        }
    }
    
    var title: String {
        switch self {
        case .cart:
            return "Sua sacola está à espera"
        case .orders:
            return "Nenhuma aquisição recente"
        case .wishlist:
            return "Sua curadoria está vazia"
        case .generic(_, let title, _):
            return title
        }
    }
    
    var message: String {
        switch self {
        case .cart:
            return "Explore nossa coleção e selecione peças exclusivas que definem seu estilo."
        case .orders:
            return "Você ainda não possui histórico de pedidos. Suas novas peças aparecerão aqui."
        case .wishlist:
            return "Salve suas inspirações e peças favoritas para não perdê-las de vista."
        case .generic(_, _, let message):
            return message
        }
    }
}
