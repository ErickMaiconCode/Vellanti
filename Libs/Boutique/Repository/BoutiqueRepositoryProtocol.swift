protocol BoutiqueRepositoryProtocol {
    func getClothingItems(for category: Category) async throws -> [ClothingItem]
}
