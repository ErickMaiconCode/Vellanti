import SwiftUI

struct AnimatedSecureField: View {
    @Binding var text: String
    let title: String
    var textContentType: UITextContentType?
    
    @FocusState private var isFocused: Bool
    @State private var isSecure: Bool = true
    
    private var shouldFloat: Bool {
        isFocused || !text.isEmpty
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            Text(title)
                .font(.system(size: shouldFloat ? 12 : 16, weight: .light))
                .foregroundStyle(isFocused ? .white : .white.opacity(0.6))
                .offset(y: shouldFloat ? -24 : 0)
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: shouldFloat)
            
            HStack {
                
                Group {
                    if isSecure {
                        SecureField("", text: $text)
                    } else {
                        TextField("", text: $text)
                    }
                }
                .font(.system(size: 16, weight: .light))
                .foregroundStyle(.white)
                .textContentType(textContentType)
                .focused($isFocused)
                .padding(.top, shouldFloat ? 8 : 0)
                
                if !text.isEmpty {
                    Button(action: { isSecure.toggle() }) {
                        Image(systemName: isSecure ? "eye.slash" : "eye")
                            .font(.system(size: 14))
                            .foregroundStyle(.white.opacity(0.6))
                    }
                }
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 0)
        .background(
            VStack {
                Spacer()
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(isFocused ? .white : .white.opacity(0.3))
            }
        )
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isFocused)
    }
}
