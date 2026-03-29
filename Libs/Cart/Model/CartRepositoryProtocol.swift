protocol CartRepositoryProtocol {
    func fetchCart(for userId: String?) -> [CartEntity]
    func add(item: ClothingItem, userId: String?)
    func remove(item: CartEntity)
    func increment(item: CartEntity)
    func decrement(item: CartEntity)
    func clear(for userId: String?)
}
