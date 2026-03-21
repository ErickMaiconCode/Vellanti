import SwiftUI

struct LoginView : View {
    var body: some View {
        ZStack {
            Image("Vellanti_Login")
                .resizable()
                .ignoresSafeArea()
            
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0.5), .black.opacity(0.7)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Image("Vellanti_Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
            }
        }
    }
}

#Preview {
    LoginView()
}
