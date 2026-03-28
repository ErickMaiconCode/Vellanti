import SwiftUI
import Combine

class ProfileCoordinator: ObservableObject {
    
    enum ProfileRoute: Hashable, Identifiable {
        case orders
        case wishList
        case cart
        case generic(String)
        case orderDetails(OrderEntity)
        
        var id: String {
            switch self {
            case .orders: return "orders"
            case .wishList: return "wishList"
            case .cart: return "cart"
            case .generic(let title): return title
            case .orderDetails(let order): return "order_\(order.id ?? UUID().uuidString)"
            }
        }
    }
    
    @Published var path = NavigationPath()
    private let container = DependencyContainer.shared
    
    func navigate(to item: ProfileList) {
        switch item.title {
        case "Meus Pedidos":
            path.append(ProfileRoute.orders)
        case "Minhas Compras":
            path.append(ProfileRoute.cart)
        case "Minha Lista de Desejos":
            path.append(ProfileRoute.wishList)
        default:
            path.append(ProfileRoute.generic(item.title))
        }
    }
    
    func showOrderDetails(_ order: OrderEntity) {
        path.append(ProfileRoute.orderDetails(order))
    }
    
    func goBack() {
        path.removeLast()
    }
    
    @ViewBuilder
    func build(route: ProfileRoute) -> some View {
        switch route {
        case .orders:
            OrdersListView(coordinator: self)
                .environmentObject(container.orderViewModel)
        case .cart:
            CartView(isPresentedAsModal: false)
                .environmentObject(container.cartViewModel)
        case .wishList:
            WishlistView()
                .environmentObject(container.wishlistViewModel)
        case .generic(let title):
            OrdersListView(coordinator: self)
                .environmentObject(container.cartViewModel)
        case .orderDetails(let order):
            OrderDetailsView(order: order)
        }
    }
}
