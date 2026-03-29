import SwiftUI
import Combine

class ProfileCoordinator: ObservableObject {
    
    enum ProfileRoute: Hashable, Identifiable {
        case orders
        case wishList
        case cart
        case generic(String)
        case orderDetails(OrderEntity)
        case adminPanel
        case login
        case register
        
        var id: String {
            switch self {
            case .orders: return "orders"
            case .wishList: return "wishList"
            case .cart: return "cart"
            case .generic(let title): return title
            case .orderDetails(let order): return "order_\(order.id ?? UUID().uuidString)"
            case .adminPanel: return "adminPanel"
            case .login: return "login"
            case .register: return "register"
            }
        }
    }
    
    @Published var path = NavigationPath()
    
    func navigate(to item: ProfileList) {
        switch item.title {
        case "Meus Pedidos":
            path.append(ProfileRoute.orders)
        case "Minhas Compras":
            path.append(ProfileRoute.cart)
        case "Minha Lista de Desejos":
            path.append(ProfileRoute.wishList)
        case "Criar Novo Produto":
            path.append(ProfileRoute.adminPanel)
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
    
    func makeProfileView() -> some View {
        return ProfileListView(coordinator: self)
            .environmentObject(AuthState.shared)
    }
    
    @ViewBuilder
    func build(route: ProfileRoute) -> some View {
        switch route {
        case .orders:
            OrdersListView(coordinator: self)
            
        case .cart:
            CartView(isPresentedAsModal: false)

        case .wishList:
            WishlistView()

        case .generic:
            OrdersListView(coordinator: self)

        case .orderDetails(let order):
            OrderDetailsView(order: order)
            
        case .adminPanel:
            CreateProductView()
            
        case .login:
            LoginView(
                onSuccess: { [weak self] in
                    self?.path.removeLast()
                },
                onBackToGateway: { [weak self] in
                    self?.path.removeLast()
                }
            )
            .navigationBarBackButtonHidden(true)
            
        case .register:
            RegisterView(
                onSuccess: { [weak self] in
                    self?.path.removeLast()
                },
                onBackToGateway: { [weak self] in
                    self?.path.removeLast()
                }
            )
            .navigationBarBackButtonHidden(true)
        }
    }
}
