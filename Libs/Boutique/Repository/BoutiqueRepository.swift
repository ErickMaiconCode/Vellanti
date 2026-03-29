import Foundation

final class BoutiqueRepository: BoutiqueRepositoryProtocol {

    private var cachedItems: [ClothingItem] = []
    
    func getClothingItems() async throws -> [ClothingItem] {
        
        if !cachedItems.isEmpty {
            return cachedItems
        }
        
        cachedItems = try await BoutiqueAPIService.shared.fetchClothingItems()
        return cachedItems
    }
    
    func getClothingItems(for category: Category) async throws -> [ClothingItem] {
        let allItems = try await getClothingItems()
        
        let filtered = allItems.filter { item in
            category.apiFilter.matches(item)
        }
        
        return filtered
    }
    
    
    func clearCache() {
        cachedItems = []
    }

    func forceReload() async throws -> [ClothingItem] {
        clearCache()
        return try await getClothingItems()
    }
    
    func createProduct(_ product: ClothingItem) async throws {
        try await BoutiqueAPIService.shared.createProduct(product)
        clearCache()
    }
}
