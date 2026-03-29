import Foundation
import XCTest
@testable import Vellanti
internal import CoreData

final class VellantiTest : XCTestCase {
    
    func testDoubleToCurrencyFormatting() {
        // Given
        let price: Double = 199.90
        
        // When
        let formattedPrice = price.toCurrency
        
        // Then
        XCTAssertTrue(formattedPrice.contains("R$"), "A formatação deve conter o símbolo do Real")
        XCTAssertTrue(formattedPrice.contains("199,90"), "Os centavos devem ser separados por vírgula no padrão pt_BR")
    }
    
    
    func testPasswordValidationRules() {
        // Senhas Inválida
        XCTAssertFalse("fraca12".isValidPassword, "Deve falhar: Menos de 8 caracteres")
        XCTAssertFalse("senhasemnumero@".isValidPassword, "Deve falhar: Não tem número")
        XCTAssertFalse("senhasemmaiuscula1@".isValidPassword, "Deve falhar: Não tem letra maiúscula")
        XCTAssertFalse("SenhaSemEspecial123".isValidPassword, "Deve falhar: Não tem caractere especial")
        
        // Senha Válida
        XCTAssertTrue("Vellanti@2024".isValidPassword, "Deve passar: Atende a todos os requisitos de segurança")
    }
    
    
    func testAuthErrorMappingForInvalidCredentials() {
        // Given
        let firebaseError = AuthError.invalidCredential
        
        // When
        let mappedErrorType = firebaseError.toErrorType()
        
        // Then
        XCTAssertEqual(mappedErrorType.title, "Senha incorreta", "O erro invalidCredential deve ser mapeado para Senha Incorreta")
    }
    

    func testPhoneFormatter() {
        // Given
        let rawPhoneBR = "11999998888"
        let rawPhoneUS = "1234567890"
        
        // When
        let formattedBR = PhoneFormatter.format(phone: rawPhoneBR, countryCode: "+55")
        let formattedUS = PhoneFormatter.format(phone: rawPhoneUS, countryCode: "+1")
        
        // Then
        XCTAssertEqual(formattedBR, "(11) 99999-8888", "O telefone brasileiro deve ter o formato (XX) XXXXX-XXXX")
        XCTAssertEqual(formattedUS, "(123) 456-7890", "O telefone americano deve ter o formato (XXX) XXX-XXXX")
    }


    func testCategoryFilteringLogic() {
        // Given
        let bag = ClothingItem(
            id: "1", name: "Bolsa Couro", brand: "Vellanti",
            category: "Bolsas", description: "", price: 1000,
            image: "", images: nil, specs: ClothingSpecs(size: "", color: "", material: "", gender: "")
        )
        
        let shoe = ClothingItem(
            id: "2", name: "Salto Alto", brand: "Vellanti",
            category: "Sapatos", description: "", price: 800,
            image: "", images: nil, specs: ClothingSpecs(size: "", color: "", material: "", gender: "")
        )
        
        let allProducts = [bag, shoe]
        
        // When
        let filteredProducts = allProducts.filter { $0.category == "Bolsas" }
        
        // Then
        XCTAssertEqual(filteredProducts.count, 1, "O filtro deve retornar apenas 1 produto")
        XCTAssertEqual(filteredProducts.first?.name, "Bolsa Couro", "O produto filtrado deve ser a Bolsa")
    }
}

  class MockCartRepository: CartRepositoryProtocol {
      func fetchCart(for userId: String?) -> [CartEntity] { return [] }
      func add(item: ClothingItem, userId: String?) {}
      func remove(item: CartEntity) {}
      func increment(item: CartEntity) {}
      func decrement(item: CartEntity) {}
      func clear(for userId: String?) {}
  }

  class MockBoutiqueRepository: BoutiqueRepositoryProtocol {
      func getClothingItems(for category: Vellanti.Category) async throws -> [ClothingItem] { return [] }
      func createProduct(_ product: ClothingItem) async throws {}
      func clearCache() {}
  }
