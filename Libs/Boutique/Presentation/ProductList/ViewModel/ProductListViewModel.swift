import SwiftUI
import Combine

final class ProductListViewModel: ObservableObject {
    @Published var clothingItems: [ClothingItem] = []
    @Published var isLoading = false
    @Published var errorType: ErrorType?
    @Published private(set) var category: Category?
    
    private let repository = BoutiqueRepository.shared
    
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
        
        Task {
            do {
                clothingItems = try await repository.getClothingItems(for: category)
                
                if clothingItems.isEmpty {
                    errorType = .emptyData("Nenhum produto encontrado nesta categoria")
                }
                
            } catch let error as NetworkError {
                errorType = ErrorType(from: error)
            } catch {
                errorType = .generic("Erro ao carregar produtos")
            }
            
            isLoading = false
        }
    }
}
