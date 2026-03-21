import Foundation

protocol WelcomeViewModelProtocol: ObservableObject {
    var userName: String { get }
    var greeting: String { get }
    var isAuthenticated: Bool { get }
    
    func completeWelcome()
}
