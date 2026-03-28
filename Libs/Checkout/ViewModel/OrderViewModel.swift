import SwiftUI
import CoreData
import Combine

class OrderViewModel: ObservableObject {
    @Published var orders: [OrderEntity] = []
    
    private let context = CoreDataManager.shared.context
    private let syncService = CoreDataSyncService.shared
    private let authState = AuthState.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchOrders()
        
        authState.$isAuthenticated
            .dropFirst()
            .sink { [weak self] _ in
                self?.fetchOrders()
            }
            .store(in: &cancellables)
    }
    
    func fetchOrders() {
        let request = NSFetchRequest<OrderEntity>(entityName: "OrderEntity")
        
        if let userId = syncService.getCurrentUserId() {
            request.predicate = NSPredicate(format: "userId == %@", userId)
        } else {
            request.predicate = NSPredicate(format: "userId == nil")
        }
        
        request.sortDescriptors = [NSSortDescriptor(keyPath: \OrderEntity.date, ascending: false)]
        
        do {
            orders = try context.fetch(request)
        } catch {
            print("Erro ao buscar pedidos: \(error)")
        }
    }
    
    func createOrder(from cartItems: [CartEntity], total: Double, address: String, paymentMethod: String) {
        
        let newOrder = OrderEntity(context: context)
        newOrder.id = UUID().uuidString
        newOrder.date = Date()
        newOrder.total = total
        newOrder.status = "Pagamento Aprovado"
        
        newOrder.shippingAddress = address
        newOrder.payment = paymentMethod
        newOrder.userId = syncService.getCurrentUserId()
        
        for cartItem in cartItems {
            let orderItem = OrderItemEntity(context: context)
            orderItem.name = cartItem.name
            orderItem.brand = cartItem.brand
            orderItem.price = cartItem.price
            orderItem.image = cartItem.image
            orderItem.size = cartItem.size
            orderItem.color = cartItem.color
            orderItem.quantity = cartItem.quantity
            orderItem.userId = syncService.getCurrentUserId()
            
            orderItem.originOrder = newOrder
        }
        
        save()
        
        fetchOrders()
    }
    
    private func save() {
        CoreDataManager.shared.save()
    }
}
