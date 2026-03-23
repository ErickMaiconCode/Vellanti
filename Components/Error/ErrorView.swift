import SwiftUI

struct ErrorView: View {
    let type: ErrorType
    let retryAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: type.icon)
                .font(.system(size: 60))
                .foregroundStyle(type.iconColor)
            
            VStack(spacing: 8) {
                Text(type.title)
                    .font(.title2)
                    .bold()
                
                Text(type.message)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            if let retryAction = retryAction {
                Button(action: retryAction) {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.clockwise")
                        Text("Tentar Novamente")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.black)
                    .cornerRadius(4)
                }
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
