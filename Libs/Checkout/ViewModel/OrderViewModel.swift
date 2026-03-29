import SwiftUI
import CoreData
import Combine

class OrderViewModel: ObservableObject {
    @Published var orders: [OrderEntity] = []
    
    private let repository: OrderRepositoryProtocol
    private let syncService = CoreDataSyncService.shared
    private let authState = AuthState.shared
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: OrderRepositoryProtocol = CoreDataOrderRepository()) {
        self.repository = repository
        fetchOrders()
        
        authState.$isAuthenticated.dropFirst().sink { [weak self] _ in
            self?.fetchOrders()
        }.store(in: &cancellables)
    }
    
    func fetchOrders() {
        orders = repository.fetchOrders(for: syncService.getCurrentUserId())
    }
    
    func createOrder(from cartItems: [CartEntity], total: Double, address: String, paymentMethod: String) {
        repository.createOrder(
            from: cartItems,
            total: total,
            address: address,
            paymentMethod: paymentMethod,
            userId: syncService.getCurrentUserId()
        )
        fetchOrders()
    }
}
