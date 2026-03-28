import SwiftUI
import Foundation

@main
struct VellantiApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject private var appCoordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                switch appCoordinator.currentScreen {
                case .loading:
                    Color.clear
                    
                case .splash:
                    appCoordinator.makeSplashView()
                    
                case .onboarding:
                    appCoordinator.makeOnboardingView()
                        .transition(.opacity)
                    
                case .authGateway:
                    appCoordinator.makeAuthGatewayView()
                        .transition(.opacity)
                    
                case .welcome:
                    appCoordinator.makeWelcomeView()
                        .transition(.opacity)
                    
                case .login:
                    appCoordinator.makeLoginView()
                        .transition(.opacity)
                    
                case .register:
                    appCoordinator.makeRegisterView()
                        .transition(.opacity)
                    
                case .main:
                    appCoordinator.makeMainView()
                        .transition(.opacity)
                 }
             }
             .animation(.easeInOut(duration: 0.5), value: appCoordinator.currentScreen)
         }
     }
}
