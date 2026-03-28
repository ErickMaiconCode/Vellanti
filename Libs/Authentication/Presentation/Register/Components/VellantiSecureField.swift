import SwiftUI

struct VellantiSecureField: View {
    @Binding var text: String
    let title: String
    var textContentType: UITextContentType?
    
    @FocusState private var isFocused: Bool
    @State private var isSecure: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.uppercased())
                .font(.system(size: 11, weight: .bold))
                .tracking(1.5)
                .foregroundStyle(.white.opacity(0.6))
            
            HStack {
                Group {
                    if isSecure {
                        SecureField("", text: $text)
                    } else {
                        TextField("", text: $text)
                    }
                }
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.white)
                .tint(.white)
                .textContentType(textContentType)
                .focused($isFocused)
                
                if !text.isEmpty {
                    Button(action: { isSecure.toggle() }) {
                        Image(systemName: isSecure ? "eye.slash" : "eye")
                            .font(.system(size: 14))
                            .foregroundStyle(.white.opacity(0.6))
                    }
                }
            }
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
