import SwiftUI

struct AnimatedTextFiel: View {
    @Binding var text: String
    let title: String
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType?
    var autocapitalization: TextInputAutocapitalization = .sentences
    
    @FocusState private var isFocused: Bool
    
    private var shouldFloat: Bool {
        isFocused || !text.isEmpty
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(title)
                .font(.system(size: shouldFloat ? 12 : 16, weight: .light))
                .foregroundStyle(isFocused ? .white : .white.opacity(0.6))
                .offset(y: shouldFloat ? -24 : 0)
                .animation(.spring(response: 0.3, dampingFraction: 0.9), value: shouldFloat)
            
            TextField("", text: $text)
                .font(.system(size: 16, weight: .light))
                .foregroundStyle(.white)
                .textContentType(textContentType)
                .keyboardType(keyboardType)
                .textInputAutocapitalization(autocapitalization)
                .focused($isFocused)
                .padding(.top, shouldFloat ? 8 : 0 )
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 0)
        .background(
            VStack{
                Spacer()
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(isFocused ? .white : .white.opacity(0.3))
            }
        )
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isFocused)
    }
}
