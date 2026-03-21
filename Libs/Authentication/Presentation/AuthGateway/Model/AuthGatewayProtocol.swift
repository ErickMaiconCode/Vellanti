import Foundation

protocol AuthGatewayProtocol {
    var messages: [WelcomeMessage] { get }
    var currentMessagesIndex: Int { get set }
    var showContinueWithoutLogin: Bool { get }
    
    func startAutoRotation()
    func stopAutoRotation()
    func nextMessage()
    func previousMessage()
    func navigateToLogin()
    func navigateToRegister()
    func continueWithoutLogin()
}
