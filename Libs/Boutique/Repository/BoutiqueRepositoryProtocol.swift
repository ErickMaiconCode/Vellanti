protocol BoutiqueRepositoryProtocol {
    func getClothingItems(for category: Category) async throws -> [ClothingItem]
    func createProduct(_ product: ClothingItem) async throws
    func clearCache()
}
