import Foundation
import SwiftUI
import Combine

@MainActor
final class AuthGatewayViewModel : ObservableObject, AuthGatewayProtocol {
    @Published var currentMessagesIndex: Int = 0
    
    let messages: [WelcomeMessage] = WelcomeMessage.messages
    let showContinueWithoutLogin: Bool
    
    private var autoRotationTimer: Timer?
    private let rotationInterval: TimeInterval = 4.0
    
    var onLoginTapped: (() -> Void)?
    var onRegisterTapped: (() -> Void)?
    var onContinueWithoutLogin: (() -> Void)?
    
    init(showContinueWithoutLogin: Bool = true) {
        self.showContinueWithoutLogin = showContinueWithoutLogin
    }
    
    func startAutoRotation() {
        stopAutoRotation()
        
        autoRotationTimer = Timer.scheduledTimer(
            withTimeInterval: rotationInterval,
            repeats: true
        ) { [ weak self ] _ in
            Task { @MainActor [ weak self ] in
                self?.nextMessage()
            }
        }
    }
    
    func stopAutoRotation() {
        autoRotationTimer?.invalidate()
        autoRotationTimer = nil
    }
    
    func nextMessage() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            currentMessagesIndex = (currentMessagesIndex + 1) % messages.count
        }
    }
    
    func previousMessage() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            currentMessagesIndex = (currentMessagesIndex - 1 + messages.count) % messages.count
        }
    }
    
    func navigateToLogin() {
        stopAutoRotation()
        onLoginTapped?()
    }
    
    func navigateToRegister() {
        stopAutoRotation()
        onRegisterTapped?()
    }
    
    func continueWithoutLogin() {
        stopAutoRotation()
        onContinueWithoutLogin?()
    }
    
    deinit {
        stopAutoRotation()
    }
}
