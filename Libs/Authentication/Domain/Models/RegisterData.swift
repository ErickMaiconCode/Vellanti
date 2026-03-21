import Foundation

struct RegisterData {
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var name: String = ""
    var lastName: String = ""
    var gender: Gender = .preferNotToSay
    var country: String = "Brasil"
    var birthDate: Date = Date()
    var phoneCountryCode: String = "+55"
    var phone: String = ""
    
    var isValid: Bool {
        !email.isEmpty &&
        !password.isEmpty &&
        password == confirmPassword &&
        password.count >= 8 &&
        !name.isEmpty &&
        !lastName.isEmpty &&
        !phone.isEmpty &&
        email.contains("@")
    }
}
