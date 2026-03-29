protocol OrderRepositoryProtocol {
    func fetchOrders(for userId: String?) -> [OrderEntity]
    func createOrder(from cartItems: [CartEntity], total: Double, address: String, paymentMethod: String, userId: String?)
}
