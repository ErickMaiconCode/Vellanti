import SwiftUI

struct Category: Identifiable, Hashable {
    let id: String
    let name: String
    let headline: String?
    let subheadline: String?
    let runwayVideo: String?
    
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
      headline: "Coleção\nPrimavera-Verão 2026",
      subheadline: "A fluidez da seda encontra a precisão da alfaiataria. Descubra a nova silhueta Vellanti.",
      runwayVideo: "Runway_Fem"
    ),
    Category(
      id: "masculino",
      name: "Masculino",
      headline: "O Novo Clássico",
      subheadline: "Redefinindo o guarda-roupa contemporâneo com cortes estruturados e materiais nobres.",
      runwayVideo: "Runway_Masc"
    ),
    Category(
      id: "casacos",
      name: "Casacos",
      headline: "Estrutura e Presença",
      subheadline: "Peças atemporais desenhadas para ser a sua armadura elegante contra o tempo.",
      runwayVideo: nil
    ),
    Category(
      id: "jaquetas",
      name: "Jaquetas",
      headline: "Atitude Silenciosa",
      subheadline: "Do couro macio ao nylon técnico. A rebeldia traduzida no mais alto padrão de acabamento.",
      runwayVideo: nil
    ),
    Category(
      id: "calcados",
      name: "Calçados",
      headline: "A Arte do Passo",
      subheadline: "Artesanato italiano e design arquitetônico. Onde a sua jornada começa.",
      runwayVideo: nil
    ),
    Category(   
      id: "bolsas",
      name: "Bolsas",
      headline: "Herança Tangível",
      subheadline: "Mais que acessórios, verdadeiros investimentos esculpidos à mão para a próxima geração.",
      runwayVideo: nil
    ),
    Category(
      id: "camisas",
      name: "Camisas",
      headline: "A Segunda Pele",
      subheadline: "O caimento perfeito em algodão egípcio e seda pura. O essencial, elevado à perfeição.",
      runwayVideo: nil
    ),
    Category(
      id: "malas",
      name: "Malas",
      headline: "Cidadão do Mundo",
      subheadline: "Engenharia de viagem projetada exclusivamente para quem domina todos os fusos horários.",
      runwayVideo: nil
    )
  ]
}
