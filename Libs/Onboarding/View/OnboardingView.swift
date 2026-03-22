import SwiftUI
import Lottie

struct OnboardingView<ViewModel: OnboardingViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            VideoPlayerView(videoName: viewModel.pages[viewModel.currentPage].videoName)
                .id(viewModel.currentPage)
                .ignoresSafeArea(.all)
            
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0.5), .black.opacity(0.8)]),
                startPoint: .center,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                VStack(spacing: 32) {
                    descriptionView
                        .padding(.horizontal, 40)
                    
                    minimalPageIndicator

                    actionButton
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 30)
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private var descriptionView: some View {
        Text(viewModel.pages[viewModel.currentPage].description)
            .font(.system(size: 20, weight: .light))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .lineSpacing(6)
            .frame(minHeight: 80)
            .transition(.opacity.combined(with: .move(edge: .bottom)))
            .animation(.easeInOut(duration: 0.4), value: viewModel.currentPage)
    }
    
    private var minimalPageIndicator: some View {
        HStack(spacing: 8) {
            ForEach(0..<viewModel.pages.count, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(index == viewModel.currentPage ? Color.white : Color.white.opacity(0.3))
                    .frame(
                        width: index == viewModel.currentPage ? 32 : 16,
                        height: 3
                    )
                    .animation(
                        .spring(response: 0.4, dampingFraction: 0.7),
                        value: viewModel.currentPage
                    )
            }
        }
    }
    
    private var actionButton: some View {
        Button(action: {
            viewModel.requestPermission()
        }) {
            Text(viewModel.pages[viewModel.currentPage].buttonTitle)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.white)
                .cornerRadius(4)
        }
        .disabled(viewModel.isLoading)
        .overlay {
            if viewModel.isLoading {
                Color.white // ✅ Fundo semi-transparente
                    .cornerRadius(4)
                
                LottieView(animation: .named("Loading_Black"))
                    .playing(loopMode: .loop)
                    .frame(width: 50, height: 50)
            }
        }
    }
}
