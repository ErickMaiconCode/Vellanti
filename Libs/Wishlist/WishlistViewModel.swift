import SwiftUI
import Combine
import CoreData

class WishlistViewModel: ObservableObject {
    @Published var wishlistItem: [WishlistEntity] = []
    
    private let context = CoreDataManager.shared.context
    private let syncService = CoreDataSyncService.shared
    private let authState = AuthState.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchWishlist()
        
        authState.$isAuthenticated
            .dropFirst()
            .sink { [weak self] _ in
                self?.fetchWishlist()
            }
            .store(in: &cancellables)
    }
    
    func fetchWishlist() {
        let request = NSFetchRequest<WishlistEntity>(entityName: "WishlistEntity")
        
        if let userId = syncService.getCurrentUserId() {
            request.predicate = NSPredicate(format: "userId == %@", userId)
        } else {
            request.predicate = NSPredicate(format: "userId == nil")
        }
    
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
            newItem.brand = item.brand 
            newItem.price = item.price
            newItem.image = item.image
            newItem.dateAdded = Date()
            newItem.userId = syncService.getCurrentUserId()
        }
        
        CoreDataManager.shared.save()
        fetchWishlist()
    }
}
