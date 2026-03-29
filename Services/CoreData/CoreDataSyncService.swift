import Foundation
import CoreData
import FirebaseFirestore

@MainActor
final class CoreDataSyncService {
    
    static let shared = CoreDataSyncService()
    
    private let coreDataManager = CoreDataManager.shared
    private var currentUserId: String?
    private let db = Firestore.firestore()
    
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
        
        async let syncOrders: () = downloadOrders(for: userId)
        async let syncWishlist: () = downloadWishlist(for: userId)

        _ = await (syncOrders, syncWishlist)
        
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
            print("Falha para sincronizar carrinho - \(error)")
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
            print("Falha para sincronizar lista de favoritos - \(error)")
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
            print("Falha para sincronizar pedidos - \(error)")
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
    
    func downloadOrders(for userId: String) async {
        do {
            let snapshot = try await db.collection("users").document(userId).collection("orders").getDocuments()
            
            CoreDataManager.shared.context.performAndWait {
                for document in snapshot.documents {
                    let data = document.data()

                    let request = NSFetchRequest<OrderEntity>(entityName: "OrderEntity")
                    request.predicate = NSPredicate(format: "id == %@", document.documentID)
                    
                    if let existing = try? CoreDataManager.shared.context.fetch(request).first {
                        continue
                    }

                    let newOrder = OrderEntity(context: CoreDataManager.shared.context)
                    newOrder.id = document.documentID
                    newOrder.userId = userId
                    newOrder.total = data["total"] as? Double ?? 0.0
                    newOrder.status = data["status"] as? String
                    newOrder.shippingAddress = data["shippingAddress"] as? String
                    newOrder.payment = data["payment"] as? String

                    if let timestamp = data["date"] as? Timestamp {
                        newOrder.date = timestamp.dateValue()
                    }

                }
                CoreDataManager.shared.save()
            }
        } catch {
            print("Erro ao baixar pedidos do Firebase: \(error)")
        }
    }

    func downloadWishlist(for userId: String) async {
        do {
            let snapshot = try await db.collection("users").document(userId).collection("wishlist").getDocuments()
            
            CoreDataManager.shared.context.performAndWait {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let request = NSFetchRequest<WishlistEntity>(entityName: "WishlistEntity")
                    request.predicate = NSPredicate(format: "id == %@", document.documentID)
                    
                    if let existing = try? CoreDataManager.shared.context.fetch(request).first {
                        continue
                    }
                    
                    let newItem = WishlistEntity(context: CoreDataManager.shared.context)
                    newItem.id = document.documentID
                    newItem.userId = userId
                    newItem.name = data["name"] as? String
                    newItem.brand = data["brand"] as? String
                    newItem.price = data["price"] as? Double ?? 0.0
                    newItem.image = data["image"] as? String
                    newItem.dateAdded = Date()
                }
                CoreDataManager.shared.save()
            }
        } catch {
            print("Erro ao baixar favoritos: \(error)")
        }
    }
}

extension CoreDataSyncService {
    
    func uploadOrder(id: String, userId: String, total: Double, address: String, payment: String, date: Date) {
        let orderData: [String: Any] = [
            "id": id,
            "total": total,
            "status": "Pagamento Aprovado",
            "shippingAddress": address,
            "payment": payment,
            "date": date
        ]
        
        db.collection("users").document(userId).collection("orders").document(id).setData(orderData)
    }
    
    // 2. Sobe o Favorito para a Nuvem
    func uploadWishlistItem(id: String, userId: String, name: String, brand: String, price: Double, image: String) {
        let itemData: [String: Any] = [
            "id": id,
            "name": name,
            "brand": brand,
            "price": price,
            "image": image,
            "dateAdded": Date()
        ]
        
        db.collection("users").document(userId).collection("wishlist").document(id).setData(itemData)
    }
    
    func removeWishlistItem(id: String, userId: String) {
        db.collection("users").document(userId).collection("wishlist").document(id).delete()
    }
}
