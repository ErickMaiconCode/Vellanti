import SwiftUI
import CoreData
import Combine

class CartViewModel: ObservableObject {
    @Published var cartItems: [CartEntity] = []
    @Published var isCartOpen: Bool = false
    
    private let context = CoreDataManager.shared.context
    private let syncService = CoreDataSyncService.shared
    private let authState = AuthState.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchCart()
        
        authState.$isAuthenticated
            .dropFirst()
            .sink{ [weak self] _ in
                self?.fetchCart()
            }
            .store(in: &cancellables)
    }
    
    var total: Double {
        cartItems.reduce(0) { $0 + ($1.price * Double($1.quantity))}
    }
    
    var formattedTotal: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "BRL"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: NSNumber(value: total)) ?? "R$ 0,00"
    }
    
    func fetchCart() {
        let request = NSFetchRequest<CartEntity>(entityName: "CartEntity")
        
        if let userId = syncService.getCurrentUserId() {
             request.predicate = NSPredicate(format: "userId == %@", userId)
         } else {
             request.predicate = NSPredicate(format: "userId == nil")
         }
         
         request.sortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: false)]
        
        do {
            cartItems = try context.fetch(request)
        } catch {
            print("Erro ao buscar items: \(error.localizedDescription)")
        }
    }
    
    func addToCart(item: ClothingItem) {
        
        if let existingItem = cartItems.first(where: {
            $0.id == item.id && $0.size == item.specs.size
        }) {
            existingItem.quantity += 1
            saveAndFetch()
            
            withAnimation {
                isCartOpen = true
            }
            return
        }
        
            let newItem = CartEntity(context: context)
            newItem.id = item.id
            newItem.name = item.name
            newItem.brand = item.brand
            newItem.price = item.price
            newItem.image = item.image
            newItem.size = item.specs.size
            newItem.color = item.specs.color
            newItem.quantity = 1
            newItem.dateAdded = Date()
            newItem.userId = syncService.getCurrentUserId()
            
            saveAndFetch()
            
            withAnimation {
                isCartOpen = true
            }
        
        }
        
        func removeItem(_ item: CartEntity) {
            context.delete(item)
            saveAndFetch()
        }
        
        func increment(item: CartEntity) {
            item.quantity += 1
            saveAndFetch()
        }
        
        func decrement(item: CartEntity) {
            if item.quantity > 1 {
                item.quantity -= 1
                saveAndFetch()
            } else {
                context.delete(item)
                saveAndFetch()
            }
        }
        
        func clearCart() {
            cartItems.forEach { context.delete($0) }
            CoreDataManager.shared.save()
            fetchCart()
        }
        
        func finishShopping() {
            if !cartItems.isEmpty {
                clearCart()
            }
            isCartOpen = false
        }
        
        func saveAndFetch() {
            CoreDataManager.shared.save()
            fetchCart()
        }
    }
