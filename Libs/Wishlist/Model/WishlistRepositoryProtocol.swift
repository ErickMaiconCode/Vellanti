protocol WishlistRepositoryProtocol {
    func fetchWishlist(for userId: String?) -> [WishlistEntity]
    func add(item: ClothingItem, userId: String?)
    func remove(item: WishlistEntity)
}
