import SwiftUI

struct EmptyStateView: View {
    let type: EmptyStateType
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(systemName: type.icon)
                .font(.system(size: 50, weight: .light))
                .foregroundStyle(Color.black)
                .padding(20)
                .background(
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
            
            VStack(spacing: 8) {
                
                Text(type.title)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(Color.black)
                
                Text(type.message)
                    .font(.system(size: 15))
                    .foregroundStyle(Color.black.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .lineSpacing(4)
            }
            
            
            Spacer()
            
            if let btnTitle = actionTitle, let btnAction = action {
                Button(action: btnAction) {
                    Text(btnTitle)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.black)
                        .cornerRadius(0)
                }
                .padding(24)
                .padding(.bottom, 20)
            }
        }
        .background(Color.white)
    }
}
