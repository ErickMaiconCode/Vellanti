import SwiftUI
import Combine
import CoreData

class WishlistViewModel: ObservableObject {
    @Published var wishlistItem: [WishlistEntity] = []
    private let context = CoreDataManager.shared.context
    
    init() {
        fetchWishlist()
    }
    
    func fetchWishlist() {
        let request = NSFetchRequest<WishlistEntity>(entityName: "WishlistEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: false)]
        
        do {
            wishlistItem = try context.fetch(request)
        } catch {
            print("Erro ao buscar wishlist: \(error)")
        }
    }
    
    func isFavorite(productId: String) -> Bool {
        return wishlistItem.contains { $0.id == productId }
    }
    
    func toggleFavorite(item: ClothingItem) {
        if let existingItem = wishlistItem.first(where: { $0.id == item.id }) {
            context.delete(existingItem)
        } else {
            
            let newItem = WishlistEntity(context: context)
            newItem.id = item.id
            newItem.name = item.name
            newItem.price = item.price
            newItem.image = item.image
            newItem.dateAdded = Date()
        }
        
        CoreDataManager.shared.save()
        fetchWishlist()
    }
}
