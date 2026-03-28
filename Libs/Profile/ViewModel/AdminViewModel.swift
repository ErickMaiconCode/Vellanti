import Foundation
import SwiftUI
import Combine

@MainActor
final class AdminViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var successMessage: String?

    @Published var name: String = ""
    @Published var brand: String = ""
    @Published var category: String = ""
    @Published var description: String = ""
    @Published var price: String = ""
    @Published var imageURL: String = ""
    @Published var size: String = ""
    @Published var color: String = ""
    @Published var material: String = ""
    @Published var gender: String = "Unissex"
    
    var isFormValid: Bool {
        !name.isEmpty &&
        !brand.isEmpty &&
        !category.isEmpty &&
        !description.isEmpty &&
        !price.isEmpty &&
        !imageURL.isEmpty &&
        !size.isEmpty &&
        !color.isEmpty &&
        !material.isEmpty &&
        Double(price) != nil
    }
    
    func createProduct() async {
        guard isFormValid else {
            errorMessage = "Por favor, preencha todos os campos corretamente."
            return
        }
        
        guard let priceValue = Double(price) else {
            errorMessage = "Preço inválido."
            return
        }
        
        isLoading = true
        errorMessage = nil
        successMessage = nil
        
        let product = ClothingItem(
            id: UUID().uuidString,
            name: name,
            brand: brand,
            category: category,
            description: description,
            price: priceValue,
            image: imageURL,
            images: [imageURL],
            specs: ClothingSpecs(
                size: size,
                color: color,
                material: material,
                gender: gender
            )
        )
        
        do {
            try await BoutiqueAPIService.shared.createProduct(product)
            clearForm()
            
            BoutiqueRepository.shared.clearCache()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.successMessage = nil
            }
        } catch {
            errorMessage = "Erro ao criar produto: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func clearForm() {
        name = ""
        brand = ""
        category = ""
        description = ""
        price = ""
        imageURL = ""
        size = ""
        color = ""
        material = ""
        gender = "Unissex"
    }
}
