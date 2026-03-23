import SwiftUI
import Lottie
import Combine

struct WelcomeView<ViewModel: WelcomeViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    @State private var isVisible = false

    private let displayDuration: Double = 5
    
    var body: some View {
        ZStack {
            Image("WelcomeTheVellanti")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            LinearGradient(
                colors: [
                    Color.black.opacity(0.2),
                    Color.black.opacity(0.5),
                    Color.black.opacity(0.8)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()
                Spacer()
                
                Image("Vellanti_WhiteBackground")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .opacity(isVisible ? 1 : 0)
                    .scaleEffect(isVisible ? 1 : 0.95)
                    .blur(radius: isVisible ? 0 : 5)
                
                Text(viewModel.title)
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(.white.opacity(0.95))
                    .multilineTextAlignment(.center)
                    .lineSpacing(8)
                    .padding(.horizontal, 40)
                    .fixedSize(horizontal: false, vertical: true)
                    .opacity(isVisible ? 1 : 0)
                    .scaleEffect(isVisible ? 1 : 0.98)
                    .blur(radius: isVisible ? 0 : 10)
                
                LottieView(animation: .named("Loading_White"))
                    .playing(loopMode: .loop)
                    .frame(width: 50, height: 50)
                    .opacity(isVisible ? 1 : 0)
                    .scaleEffect(isVisible ? 1 : 0.98)
                    .blur(radius: isVisible ? 0 : 10)
                
                Spacer()
                Spacer()
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            performCinematicEntrance()
        }
    }
    
    private func performCinematicEntrance() {
        withAnimation(.easeOut(duration: 1.5)) {
            isVisible = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + displayDuration) {
            withAnimation(.easeIn(duration: 0.8)) {
                isVisible = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                viewModel.completeWelcome()
            }
        }
    }
}


class MockWelcomeViewModel: WelcomeViewModelProtocol {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func completeWelcome() {
        print("Navegação simulada: Welcome concluído")
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeView(viewModel: MockWelcomeViewModel(
                title: "O verdadeiro luxo vive na sutileza.\nBem-vindo ao universo Vellanti."
            ))
            .previewDisplayName("Visitante (Texto Longo)")
            
            WelcomeView(viewModel: MockWelcomeViewModel(
                title: "Sua coleção particular o aguarda, Sr. Ricardo."
            ))
            .previewDisplayName("Usuário Logado")
        }
    }
}
