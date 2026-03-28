import Foundation
import CoreData

@MainActor
final class CoreDataSyncService {
    
    static let shared = CoreDataSyncService()
    
    private let coreDataManager = CoreDataManager.shared
    private var currentUserId: String?
    
    private var context: NSManagedObjectContext {
        coreDataManager.context
    }
    
    func setupUserContext(userId: String) async {
        self.currentUserId = userId
        await associateOrphanItems(to: userId)
    }
    
    func syncUserData(userId: String) async {
        self.currentUserId = userId

        await syncCart(userId: userId)

        await syncWishList(userId: userId)

        await syncOrders(userId: userId)
        
        await syncOrders(userId: userId)
    }
    
    private func syncCart(userId: String) async {
        let fetchRequest: NSFetchRequest<CartEntity> = CartEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId == %@ OR userId == nil", userId)
        
        do {
            let items = try context.fetch(fetchRequest)
            
            var updated = 0
            
            for item in items where item.userId == nil {
                item.userId = userId
                updated += 1
            }
            
            if updated > 0 {
                coreDataManager.save()
            }
        } catch {
            print("Falha para sicronizar carrinho - \(error)")
        }
    }
    
    private func syncWishList(userId: String) async {
        let fetchRequest: NSFetchRequest<WishlistEntity> = WishlistEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId == %@ OR userId == nil", userId)
        
        do {
            let items = try context.fetch(fetchRequest)
            
            var updated = 0
            
            for item in items where item.userId == nil {
                item.userId = userId
                updated += 1
            }
            
            if updated > 0 {
                coreDataManager.save()
            }
        } catch {
            print("Falha para sicronizar lista de favoritos - \(error)")
        }
    }
    
    private func syncOrders(userId: String) async {
        let fetchRequest: NSFetchRequest<OrderEntity> = OrderEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId == %@ OR userId == nil", userId)
        
        do {
            let orders = try context.fetch(fetchRequest)

            var updatedOrders = 0
            var updatedItems = 0
            
            for order in orders where order.userId == nil {
                // Atualizar o pedido
                order.userId = userId
                updatedOrders += 1
                
                if let items = order.items as? Set<OrderItemEntity> {
                    for item in items where item.userId == nil {
                        item.userId = userId
                        updatedItems += 1
                    }
                }
            }
            
            if updatedOrders > 0 {
                coreDataManager.save()
            }
            
        } catch {
            print("Falha para sicronizar pedidos - \(error)")
        }
    }
    
    private func associateOrphanItems(to userId: String) async {
        
        await syncCart(userId: userId)
        
        await syncWishList(userId: userId)
        
        await syncOrders(userId: userId)
    }
    
    func clearLocalData() {
        
        clearEntity(CartEntity.self)
        clearEntity(WishlistEntity.self)
        
        currentUserId = nil
    }
    
    private func clearEntity<T: NSManagedObject>(_ entityType: T.Type) {
        let entityName = String(describing: entityType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            coreDataManager.save()
        } catch {
            print("Falha em limpar entidade - \(error)")
        }
    }
    
    func getUserPredicate() -> NSPredicate? {
        guard let userId = currentUserId else {
            return nil
        }
        return NSPredicate(format: "userId == %@", userId)
    }
    
    
    func getCurrentUserId() -> String? {
        return currentUserId
    }
    
    func save() {
        coreDataManager.save()
    }
}
