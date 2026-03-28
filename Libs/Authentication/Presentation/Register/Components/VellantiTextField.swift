import SwiftUI

struct VellantiTextField: View {
    @Binding var text: String
    let title: String
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType?
    var autocapitalization: TextInputAutocapitalization = .sentences
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.uppercased())
                .font(.system(size: 11, weight: .bold))
                .tracking(1.5)
                .foregroundStyle(.white.opacity(0.6))
            
            TextField("", text: $text)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.white)
                .tint(.white)
                .textContentType(textContentType)
                .keyboardType(keyboardType)
                .textInputAutocapitalization(autocapitalization)
                .focused($isFocused)
                .padding(.vertical, 8)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(isFocused || !text.isEmpty ? .white : .white.opacity(0.3)),
                    alignment: .bottom
                )
        }
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}
