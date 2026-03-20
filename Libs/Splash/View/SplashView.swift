import SwiftUI
import Lottie

struct SplashScreenView<ViewModel: SplashViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            Color("BackgroundTheme")
                .ignoresSafeArea()
            
            if !viewModel.isTransitionComplete {
                LottieView(animation: .named("Vellanti_Light"))
                    .playing(loopMode: .playOnce)
                    .frame(width: 400, height: 400)
                    .scaleEffect(viewModel.shouldZoom ? 10 : 1)
                    .opacity(viewModel.shouldZoom ? 0 : 1)
            }
        }
        .onAppear {
            viewModel.startAnimationSequence()
        }
    }
}
