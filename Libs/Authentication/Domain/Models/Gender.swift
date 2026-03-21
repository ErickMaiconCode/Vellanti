import Foundation

enum Gender: String, Codable, CaseIterable {
    case mr = "Sr"
    case mrs = "Sra"
    case miss = "Srta"
    case mx = "SrX"
    case preferNotToSay = "prefiro_nao_falar"
    
    var title: String {
        switch self {
        case .mr: return "Sr."
        case .mrs: return "Sra."
        case .miss: return "Srta."
        case .mx: return "SrX."
        case .preferNotToSay: return ""
        }
    }
    
    var displayName: String {
        switch self {
        case .mr: return "Senhor"
        case .mrs: return "Senhora"
        case .miss: return "Senhorita"
        case .mx: return "Não-Binário"
        case .preferNotToSay: return "Prefiro não informar"
        }
    }
}
