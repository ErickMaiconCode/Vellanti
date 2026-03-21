import SwiftUI

struct AuthGatewayView: View {
    
    @StateObject var viewModel: AuthGatewayViewModel
    
    var body: some View {
        ZStack {
            Image("Vellanti_Login")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            LinearGradient(
                colors: [
                    Color.black.opacity(0.7),
                    Color.black.opacity(0.5),
                    Color.black.opacity(0.7)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 80)
                
                Spacer()
                
                Image("Vellanti_Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .padding(.bottom, 10)
                
                messagesCarousel
                    .frame(height: 100)
                    .padding(.horizontal, 40)
                
                Spacer()
                
                // Buttons
                buttonsSection
                    .padding(.horizontal, 32)
                    .padding(.bottom, 30)
            }
        }
        .onAppear {
            viewModel.startAutoRotation()
        }
        .onDisappear {
            viewModel.stopAutoRotation()
        }
    }
    
    private var messagesCarousel: some View {
        VStack(spacing: 20) {
            TabView(selection: $viewModel.currentMessagesIndex) {
                ForEach(Array(viewModel.messages.enumerated()), id: \.element.id) { index, message in
                    Text(message.text)
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineSpacing(6)
                        .padding(.horizontal, 20)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 100)
            
            pageIndicator
        }
    }
    
    private var pageIndicator: some View {
        HStack(spacing: 8) {
            ForEach(0..<viewModel.messages.count, id: \.self) { index in
                pageIndicatorDot(for: index)
            }
        }
    }

    @ViewBuilder
    private func pageIndicatorDot(for index: Int) -> some View {
        let isSelected = index == viewModel.currentMessagesIndex
        
        Capsule()
            .fill(Color.white.opacity(isSelected ? 1.0 : 0.3))
            .frame(
                width: isSelected ? 24 : 8,
                height: 3
            )
            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: viewModel.currentMessagesIndex)
    }
    
    private var buttonsSection: some View {
        VStack(spacing: 16) {
            Button(action: viewModel.navigateToLogin) {
                Text("Entrar")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.white)
                    .cornerRadius(4)
            }
            
            Button(action: viewModel.navigateToRegister) {
                Text("Criar Conta")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.white, lineWidth: 1.5)
                    )
            }
            
            if viewModel.showContinueWithoutLogin {
                Button(action: viewModel.continueWithoutLogin) {
                    Text("Continuar sem login")
                        .font(.system(size: 15, weight: .light))
                        .foregroundColor(.white.opacity(0.8))
                        .underline()
                        .padding(.top, 8)
                }
            }
        }
    }
}

#Preview {
    AuthGatewayView(
        viewModel: AuthGatewayViewModel(showContinueWithoutLogin: true)
    )
}
