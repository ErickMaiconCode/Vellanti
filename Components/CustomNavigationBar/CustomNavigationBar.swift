import SwiftUI

struct CustomNavigationBar: View {
    let title: String?
    let onBack: () -> Void
    
    init(title: String? = nil, onBack: @escaping () -> Void) {
        self.title = title
        self.onBack = onBack
    }
    
    var body: some View {
        HStack {
            Button(action: onBack) {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 40, height: 40)
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                }
            }
            
            if let title = title {
                Spacer()
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.trailing, 40)
                Spacer()
            } else {
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
        .padding(.bottom, 12)
    }
}
