import SwiftUI
import CoreData
import Combine

class CartViewModel: ObservableObject {
    @Published var cartItems: [CartEntity] = []
    @Published var isCartOpen: Bool = false
    
    private let repository: CartRepositoryProtocol
    private let syncService = CoreDataSyncService.shared
    private let authState = AuthState.shared
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: CartRepositoryProtocol = CoreDataCartRepository()) {
        self.repository = repository
        fetchCart()
        
        authState.$isAuthenticated.dropFirst().sink { [weak self] _ in
            self?.fetchCart()
        }.store(in: &cancellables)
    }
    
    var total: Double {
        cartItems.reduce(0) { $0 + ($1.price * Double($1.quantity))}
    }
    
    var formattedTotal: String {
        total.toCurrency
    }
    
    func fetchCart() {
        cartItems = repository.fetchCart(for: syncService.getCurrentUserId())
    }
    
    func addToCart(item: ClothingItem) {
        repository.add(item: item, userId: syncService.getCurrentUserId())
        fetchCart()
        withAnimation { isCartOpen = true }
    }
    
    func removeItem(_ item: CartEntity) {
        repository.remove(item: item)
        fetchCart()
    }
    
    func increment(item: CartEntity) {
        repository.increment(item: item)
        fetchCart()
    }
    
    func decrement(item: CartEntity) {
        repository.decrement(item: item)
        fetchCart()
    }
    
    func clearCart() {
        repository.clear(for: syncService.getCurrentUserId())
        fetchCart()
    }
    
    func finishShopping() {
        if !cartItems.isEmpty { clearCart() }
        isCartOpen = false
    }
}
