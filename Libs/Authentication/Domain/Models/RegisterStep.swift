enum RegisterStep: Int, CaseIterable {
    case authentication = 0
    case personalData = 1
    case contact = 2
    
    var title: String {
        switch self {
        case .authentication:
            return "Crie Sua Conta"
        case .personalData:
            return "Suas Informações"
        case .contact:
            return "Suas Informações"
        }
    }
    
    
}
