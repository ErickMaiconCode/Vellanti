import SwiftUI
import Combine
import CoreData

class WishlistViewModel: ObservableObject {
    @Published var wishlistItem: [WishlistEntity] = []
    
     private let repository: WishlistRepositoryProtocol
     private let syncService = CoreDataSyncService.shared
     private let authState = AuthState.shared
     private var cancellables = Set<AnyCancellable>()
     
     init(repository: WishlistRepositoryProtocol = CoreDataWishlistRepository()) {
         self.repository = repository
         fetchWishlist()
         
         authState.$isAuthenticated.dropFirst().sink { [weak self] _ in
             self?.fetchWishlist()
         }.store(in: &cancellables)
     }
     
     func fetchWishlist() {
         wishlistItem = repository.fetchWishlist(for: syncService.getCurrentUserId())
     }
     
     func isFavorite(productId: String) -> Bool {
         return wishlistItem.contains { $0.id == productId }
     }
     
     func toggleFavorite(item: ClothingItem) {
         if let existingItem = wishlistItem.first(where: { $0.id == item.id }) {
             repository.remove(item: existingItem)
         } else {
             repository.add(item: item, userId: syncService.getCurrentUserId())
         }
         fetchWishlist()
     }
 }
