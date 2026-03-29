import SwiftUI
import Foundation

@main
struct VellantiApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject private var appCoordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
             ZStack {
                 Color.black.ignoresSafeArea()
                 
                 Group {
                     switch appCoordinator.currentScreen {
                     case .loading:
                         Color.clear
                     case .splash:
                         appCoordinator.makeSplashView()
                     case .onboarding:
                         appCoordinator.makeOnboardingView()
                     case .authGateway:
                         appCoordinator.makeAuthGatewayView()
                     case .welcome:
                         appCoordinator.makeWelcomeView()
                     case .login:
                         appCoordinator.makeLoginView()
                     case .register:
                         appCoordinator.makeRegisterView()
                     case .main:
                         appCoordinator.makeMainView()
                     }
                 }

                 .transition(.opacity)
                 .id(appCoordinator.currentScreen)
              }
             .animation(.easeInOut(duration: 0.4), value: appCoordinator.currentScreen)
          }
      }
 }
