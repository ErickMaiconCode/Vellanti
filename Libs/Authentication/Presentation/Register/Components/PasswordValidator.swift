import SwiftUI

struct PasswordValidatorView: View {
    let password: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ValidationRow(text: "Mínimo de 8 caracteres", isValid: password.count >= 8)
            ValidationRow(text: "Letra maiúscula", isValid: password.contains(where: { $0.isUppercase }))
            ValidationRow(text: "Letra minúscula", isValid: password.contains(where: { $0.isLowercase }))
            ValidationRow(text: "Número", isValid: password.contains(where: { $0.isNumber }))
            ValidationRow(text: "Caractere especial (!@#$)", isValid: password.containsSpecialCharacter)
        }
    }
}

struct ValidationRow: View {
    let text: String
    let isValid: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: isValid ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 12))
                .foregroundColor(isValid ? .white : .white.opacity(0.3))
            
            Text(text)
                .font(.system(size: 12, weight: .light))
                .foregroundStyle(isValid ? .white : .white.opacity(0.6))
        }
    }
}

extension String {
    var containsSpecialCharacter: Bool {
        let specialCharacters = "!@#$%^&*()_+-=[]{}|;:,.<>?"
        return self.contains(where: { specialCharacters.contains($0) })
    }
    
    var isValidPassword: Bool {
        self.count >= 8 &&
        self.contains(where: { $0.isUppercase }) &&
        self.contains(where: { $0.isLowercase }) &&
        self.contains(where: { $0.isNumber }) &&
        self.containsSpecialCharacter
    }
}
