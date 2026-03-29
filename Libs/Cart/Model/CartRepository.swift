import CoreData

final class CoreDataCartRepository: CartRepositoryProtocol {
    private let context = CoreDataManager.shared.context
    
    func fetchCart(for userId: String?) -> [CartEntity] {
        let request = NSFetchRequest<CartEntity>(entityName: "CartEntity")
        request.predicate = userId != nil ? NSPredicate(format: "userId == %@", userId!) : NSPredicate(format: "userId == nil")
        request.sortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: false)]
        
        var results: [CartEntity] = []

        context.performAndWait {
            results = (try? context.fetch(request)) ?? []
        }
        
        return results
    }
    
    func add(item: ClothingItem, userId: String?) {
        
        context.performAndWait {
            let cartItems = self.fetchCart(for: userId)
            
            if let existingItem = cartItems.first(where: { $0.id == item.id && $0.size == item.specs.size }) {
                existingItem.quantity += 1
            } else {
                let newItem = CartEntity(context: context)
                newItem.id = item.id
                newItem.name = item.name
                newItem.brand = item.brand
                newItem.price = item.price
                newItem.image = item.image
                newItem.size = item.specs.size
                newItem.color = item.specs.color
                newItem.quantity = 1
                newItem.dateAdded = Date()
                newItem.userId = userId
            }
            CoreDataManager.shared.save()
        }
    }
    
    func remove(item: CartEntity) {
        context.performAndWait {
            self.context.delete(item)
            CoreDataManager.shared.save()
        }
    }
    
    func increment(item: CartEntity) {
        item.quantity += 1
        CoreDataManager.shared.save()
    }
    
    func decrement(item: CartEntity) {
        if item.quantity > 1 {
            item.quantity -= 1
        } else {
            context.delete(item)
        }
        CoreDataManager.shared.save()
    }
    
    func clear(for userId: String?) {
        let items = fetchCart(for: userId)
        items.forEach { context.delete($0) }
        CoreDataManager.shared.save()
    }
}
