import SwiftUI

struct LuxuryTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(placeholder)
                .font(.system(size: 11, weight: .bold))
                .tracking(1.5)
                .foregroundColor(.white.opacity(0.6))
            
            TextField("", text: $text)
                .keyboardType(keyboardType)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.white)
                .accentColor(.white)
                .padding(.vertical, 8)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(text.isEmpty ? .white.opacity(0.3) : .white),
                    alignment: .bottom
                )
        }
    }
}

struct LuxurySecureField: View {
    let placeholder: String
    @Binding var text: String
    @State private var isVisible: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(placeholder)
                .font(.system(size: 11, weight: .bold))
                .tracking(1.5)
                .foregroundColor(.white.opacity(0.6))
            
            HStack {
                if isVisible {
                    TextField("", text: $text)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.white)
                        .accentColor(.white)
                } else {
                    SecureField("", text: $text)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.white)
                        .accentColor(.white)
                }
                
                Button(action: { isVisible.toggle() }) {
                    Image(systemName: isVisible ? "eye.slash" : "eye")
                        .foregroundColor(.white.opacity(0.5))
                        .font(.system(size: 14))
                }
            }
            .padding(.vertical, 8)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(text.isEmpty ? .white.opacity(0.3) : .white),
                alignment: .bottom
            )
        }
    }
}
