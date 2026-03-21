import Foundation
import SwiftUI

@main
struct VellantiApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @State private var currentScreen: Screen = .loading
    private let container = DependencyContainer.shared
    
    enum Screen {
        case loading
        case splash
        case onboarding
        case authGateway
        case welcome
        case home
        case login
        case register
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
                    
                case .authGateway:
                    makeAuthGatewayView()
                        .transition(.opacity)
                    
                case .welcome:
                    makeWelcomeView()
                        .transition(.opacity)
                    
                case .login:
                    Text("Login")
                        .onTapGesture {
                            currentScreen = .authGateway
                        }
                    
                case .register:
                    Text("Resgister")
                        .onTapGesture {
                            currentScreen = .authGateway
                        }
                    
                case .home:
                     Text("Home")
                         .onTapGesture {
                             container.onboardingRepository.makeOnboardingAsCompleted()
                             currentScreen = .loading
                        }
                 }
             }
             .animation(.easeInOut(duration: 0.3), value: currentScreen)
         }
     }
    
    private func checkInitialScreen() {
        if container.onboardingRepository.hasCompletedOnboarding() {
            currentScreen = .authGateway
        } else {
            currentScreen = .onboarding
        }
    }
    
    private func makeSplashView() -> some View {
        let coordinator = container.makeSplashCoordinator {
            if container.onboardingRepository.hasCompletedOnboarding() {
                currentScreen = .authGateway
            } else {
                currentScreen = .onboarding
            }
        }
        return coordinator.makeSplashView()
    }
    
    private func makeOnboardingView() -> some View {
        let coordinator = container.makeOnboardingCoordinator {
            currentScreen = .authGateway
        }
        return coordinator.makeOnboardingView()
    }
    
    private func makeAuthGatewayView() -> some View {
        let coordinator = container.makeAuthGatewayCoordinator(
            showContinueWithoutLogin: true,
            onLoginTapped: {
                currentScreen = .login
            },
            onRegisterTapped: {
                currentScreen = .register
            },
            onContinueWithoutLogin: {
                currentScreen = .home
            }
        )
        return coordinator.makeAuthGatewayView()
    }
    
    private func makeWelcomeView() -> some View {
        let coordinator = container.makeWelcomeCoordinator()
        
        coordinator.onComplete = {
            currentScreen = .home
        }
        return coordinator.makeWelcomeView()
    }
}
