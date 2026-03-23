import SwiftUI

struct Category: Identifiable, Hashable {
    let id: String
    let name: String
    let runwayVideo: String? // ✅ Opcional
    
    var apiFilter: CategoryFilter {
        switch id {
        case "feminino":
            return .gender("Feminino")
        case "masculino":
            return .gender("Masculino")
        case "casacos":
            return .category("Casacos")
        case "jaquetas":
            return .category("Jaquetas")
        case "calcados":
            return .category("Calçados")
        case "bolsas":
            return .category("Bolsas")
        case "camisas":
            return .category("Camisas")
        case "malas":
            return .category("Malas")
        default:
            return .all
        }
    }
}

enum CategoryFilter {
    case all
    case gender(String)
    case category(String)
    
    func matches(_ item: ClothingItem) -> Bool {
        switch self {
        case .all:
            return true
        case .gender(let gender):
            return item.specs.gender.lowercased() == gender.lowercased()
        case .category(let category):
            return item.category.lowercased() == category.lowercased()
        }
    }
}

extension Category {
    static let all: [Category] = [
        Category(
            id: "feminino",
            name: "Feminino",
            runwayVideo: "Onboarding_3"
        ),
        Category(
            id: "masculino",
            name: "Masculino",
            runwayVideo: "runway_men_fw24"
        ),
        Category(
            id: "casacos",
            name: "Casacos",
            runwayVideo: nil
        ),
        Category(
            id: "jaquetas",
            name: "Jaquetas",
            runwayVideo: nil
        ),
        Category(
            id: "calcados",
            name: "Calçados",
            runwayVideo: nil
        ),
        Category(
            id: "bolsas",
            name: "Bolsas",
            runwayVideo: "runway_bags_ss24"
        ),
        Category(
            id: "camisas",
            name: "Camisas",
            runwayVideo: nil
        ),
        Category(
            id: "malas",
            name: "Malas",
            runwayVideo: nil
        )
    ]
}
