import CoreData

final class CoreDataOrderRepository: OrderRepositoryProtocol {
    private let context = CoreDataManager.shared.context
    
    func fetchOrders(for userId: String?) -> [OrderEntity] {
        let request = NSFetchRequest<OrderEntity>(entityName: "OrderEntity")
        request.predicate = userId != nil ? NSPredicate(format: "userId == %@", userId!) : NSPredicate(format: "userId == nil")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \OrderEntity.date, ascending: false)]
        
        var results: [OrderEntity] = []
        
        context.performAndWait {
            results = (try? context.fetch(request)) ?? []
        }
        
        return results
    }
    
    func createOrder(from cartItems: [CartEntity], total: Double, address: String, paymentMethod: String, userId: String?) {
            guard let userId = userId else { return } // Garante que tem usuário logado
            
            let orderId = UUID().uuidString
            let orderDate = Date()
            
            context.performAndWait {
                let newOrder = OrderEntity(context: context)
                newOrder.id = orderId
                newOrder.date = orderDate
                newOrder.total = total
                newOrder.status = "Pagamento Aprovado"
                newOrder.shippingAddress = address
                newOrder.payment = paymentMethod
                newOrder.userId = userId
                
                for cartItem in cartItems {
                    let orderItem = OrderItemEntity(context: context)
                    orderItem.name = cartItem.name
                    orderItem.brand = cartItem.brand
                    orderItem.price = cartItem.price
                    orderItem.image = cartItem.image
                    orderItem.size = cartItem.size
                    orderItem.color = cartItem.color
                    orderItem.quantity = cartItem.quantity
                    orderItem.userId = userId
                    orderItem.originOrder = newOrder
                }
                CoreDataManager.shared.save()
            }
 
            CoreDataSyncService.shared.uploadOrder(
                id: orderId,
                userId: userId,
                total: total,
                address: address,
                payment: paymentMethod,
                date: orderDate
            )
        }
}
