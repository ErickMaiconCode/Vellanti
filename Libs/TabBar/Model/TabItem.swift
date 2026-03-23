import Foundation

enum TabItem: Int, CaseIterable {
    case home = 0
    case boutique = 1
    case brandStory = 2
    case profile = 3
    
    var title: String {
        switch self {
        case .home:
            return "Início"
        case .boutique:
            return "Boutique"
        case .brandStory:
            return "História"
        case .profile:
            return "Perfil"
        }
    }
}

enum TabBarTheme {
    case dark
    case light
}
