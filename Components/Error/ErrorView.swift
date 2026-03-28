import SwiftUI

struct ErrorView: View {
    let type: ErrorType
    let retryAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(systemName: type.icon)
                .font(.system(size: 50, weight: .light))
                .foregroundStyle(type.iconColor)
                .padding(20)
                .background(
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
            
            VStack(spacing: 12) {
                Text(type.title)
                    .font(.system(size: 24, weight: .regular))
                    .foregroundStyle(Color.black)
                
                Text(type.message)
                    .font(.system(size: 15))
                    .foregroundStyle(Color.black.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .lineSpacing(4)
            }
            
            Spacer()
            
            if let retryAction = retryAction {
                Button(action: retryAction) {
                    Text("Tentar Novamente")
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
        .padding()
    }
}

#Preview {
    VStack(spacing: 40) {
        ErrorView(type: .noConnection) {
            print("Retry")
        }
        
        Divider()
        
        ErrorView(type: .emptyData("Nenhum produto encontrado"), retryAction: nil)
    }
}
