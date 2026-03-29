import SwiftUI
import Combine

@MainActor
final class ProductListViewModel: ObservableObject {
    @Published var clothingItems: [ClothingItem] = []
    @Published var isLoading = false
    @Published var errorType: ErrorType?
    @Published private(set) var category: Category?
    
    private let repository: BoutiqueRepositoryProtocol
    private var loadTask: Task<Void, Never>?

    init(repository: BoutiqueRepositoryProtocol) {
        self.repository = repository
    }
    
    deinit {
        loadTask?.cancel()
    }
    
    func configure(with category: Category) {
        guard self.category == nil else { return }
        self.category = category
        loadItems()
    }
    
    func loadItems() {
        guard let category = category else {
            errorType = .generic("Categoria não definida")
            return
        }
        guard !isLoading else { return }
        
        isLoading = true
        errorType = nil
        loadTask?.cancel()
        
        loadTask = Task {
            do {
                let items = try await repository.getClothingItems(for: category)

                guard !Task.isCancelled else { return }
                
                self.clothingItems = items
                
                if clothingItems.isEmpty {
                    errorType = .emptyData("Nossa curadoria para esta seção está sendo finalizada.")
                }
                
            } catch let error as NetworkError {
                guard !Task.isCancelled else { return }
                errorType = ErrorType(from: error)
            } catch {
                guard !Task.isCancelled else { return }
                errorType = .generic("Algo inesperado ocorreu. Estamos trabalhando para restaurar sua experiência.")
            }
            
            guard !Task.isCancelled else { return }
            isLoading = false
        }
    }
}
