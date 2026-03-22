import Foundation

struct User : Identifiable, Codable {
    let id: String
    let email: String
    let name: String
    let lastName: String
    let gender: Gender
    let country: String
    let birthDate: Date
    let phoneCountryCode: String
    let phone: String
    let role: UserRole
    let createdAt: Date
    
    var isAdmin: Bool {
        role == .admin
    }
    
    var fullName: String {
        "\(name) \(lastName)"
    }
    
    var formalGreeting: String {
        if gender == .preferNotToSay || gender.title.isEmpty {
            return fullName
        }
        return "\(gender.title) \(lastName)"
    }
}
