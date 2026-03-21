import SwiftUI

struct WelcomeView<ViewModel: WelcomeViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    @State private var isAnimating = false
    
    private let displayDuration: Double = 3.0
    
    var body: some View {
        ZStack {
            backgroundView
            
            contentView
        }
        .ignoresSafeArea()
        .onAppear {
            startAnimations()
            scheduleAutoAdvance()
        }
    }
    
    private var backgroundView: some View {
        Image("WelcomeTheVellanti")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .overlay(
                LinearGradient(
                    colors: [
                        Color.black.opacity(0.4),
                        Color.black.opacity(0.6),
                        Color.black.opacity(0.7)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
    
    private var contentView: some View {
        VStack(spacing: 0) {
            Spacer()
            
            logoView
                .opacity(isAnimating ? 1 : 0)
                .scaleEffect(isAnimating ? 1 : 0.8)
                .animation(
                    .spring(response: 0.6, dampingFraction: 0.8)
                    .delay(0.2),
                    value: isAnimating
                )
            
            Spacer()
                .frame(height: 60)
            
            titleView
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 20)
                .animation(
                    .spring(response: 0.6, dampingFraction: 0.8)
                    .delay(0.4),
                    value: isAnimating
                )
            
            Spacer()
                .frame(height: 16)
            
            userNameView
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 20)
                .animation(
                    .spring(response: 0.6, dampingFraction: 0.8)
                    .delay(0.6),
                    value: isAnimating
                )
            
            Spacer()
                .frame(height: 12)
            
            subtitleView
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 20)
                .animation(
                    .spring(response: 0.6, dampingFraction: 0.8)
                    .delay(0.8),
                    value: isAnimating
                )
            
            Spacer()
        }
        .padding(.horizontal, 32)
    }
    
    private var logoView: some View {
        Image("Vellanti_WhiteBackground")
            .resizable()
            .scaledToFit()
            .frame(width: 120, height: 120)
    }
    
    private var titleView: some View {
        Text("Bem-vindo ao Vellanti")
            .font(.system(size: 28, weight: .light))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
    }
    
    private var userNameView: some View {
        Text(viewModel.userName)
            .font(.system(size: 24, weight: .semibold))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
    }
    
    private var subtitleView: some View {
        Text(viewModel.greeting)
            .font(.system(size: 17, weight: .light))
            .foregroundColor(.white.opacity(0.8))
            .multilineTextAlignment(.center)
            .lineLimit(2)
    }
    
    private func startAnimations() {
        withAnimation {
            isAnimating = true
        }
    }
    
    private func scheduleAutoAdvance() {
        DispatchQueue.main.asyncAfter(deadline: .now() + displayDuration) {
            viewModel.completeWelcome()
        }
    }
}
