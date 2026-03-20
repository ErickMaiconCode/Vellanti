import Foundation
import SwiftUI

@main
struct VellantiApp: App {
    
    @State private var currentScreen: Screen = .loading
    private let container = DependencyContainer.shared
    
    enum Screen {
        case loading
        case splash
        case onboarding
        case home
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                switch currentScreen {
                case .loading:
                    Color.clear
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation(.easeIn(duration: 0.2)) {
                                    currentScreen = .splash
                                }
                            }
                        }
                    
                case .splash:
                    makeSplashView()
                    
                case .onboarding:
                    makeOnboardingView()
                        .transition(.opacity)
                    
                case .home:
                    Text("Home")
                }
            }
            .animation(.easeInOut(duration: 0.3), value: currentScreen)
        }
    }
    
    private func checkInitialScreen() {
        if container.onboardingRepository.hasCompletedOnboarding() {
            currentScreen = .home
        } else {
            currentScreen = .onboarding
        }
    }
    
    private func makeSplashView() -> some View {
        let coordinator = container.makeSplashCoordinator {
            if container.onboardingRepository.hasCompletedOnboarding() {
                currentScreen = .home
            } else {
                currentScreen = .onboarding
            }
        }
        return coordinator.makeSplashView()
    }
    
    private func makeOnboardingView() -> some View {
        let coordinator = container.makeOnboardingCoordinator {
            currentScreen = .home
        }
        return coordinator.makeOnboardingView()
    }
}
