import CoreData

final class CoreDataWishlistRepository: WishlistRepositoryProtocol {
    private let context = CoreDataManager.shared.context
    
    func fetchWishlist(for userId: String?) -> [WishlistEntity] {
        let request = NSFetchRequest<WishlistEntity>(entityName: "WishlistEntity")
        request.predicate = userId != nil ? NSPredicate(format: "userId == %@", userId!) : NSPredicate(format: "userId == nil")
        request.sortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: false)]
        
        return (try? context.fetch(request)) ?? []
    }
    
    func add(item: ClothingItem, userId: String?) {
        let newItem = WishlistEntity(context: context)
        newItem.id = item.id
        newItem.name = item.name
        newItem.brand = item.brand
        newItem.price = item.price
        newItem.image = item.image
        newItem.dateAdded = Date()
        newItem.userId = userId
        CoreDataManager.shared.save()
    }
    
    func remove(item: WishlistEntity) {
        context.performAndWait {
            self.context.delete(item)
            CoreDataManager.shared.save()
        }
    }
}
