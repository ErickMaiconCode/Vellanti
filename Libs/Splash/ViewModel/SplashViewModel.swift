import SwiftUI
import Combine

@MainActor
final class SplashViewModel: SplashViewModelProtocol {

    @Published var isLogoVisible: Bool = true
    @Published var shouldZoom: Bool = false
    @Published var isTransitionComplete: Bool = false
    
    private var coordinator: SplashCoordinatorProtocol?
    private let repository: OnboardingRepositoryProtocol
    
    private let lottiePlayTime: Double = 3.7
    private let zoomDuration: Double = 1.5
    
    init(
        coordinator: SplashCoordinatorProtocol,
        repository: OnboardingRepositoryProtocol
    ) {
        self.coordinator = coordinator
        self.repository = repository
    }
    
    func startAnimationSequence() {
        Task {
            try? await Task.sleep(nanoseconds: UInt64(lottiePlayTime * 1_000_000_000))

            await MainActor.run {
                withAnimation(.easeIn(duration: zoomDuration)) {
                    shouldZoom = true
                }
            }

            try? await Task.sleep(nanoseconds: UInt64(zoomDuration * 1_000_000_000))

            await MainActor.run {
                isTransitionComplete = true
                coordinator?.splashDidFinish()
            }
        }
    }
}
