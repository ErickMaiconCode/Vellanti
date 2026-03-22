import Foundation

protocol WelcomeViewModelProtocol: ObservableObject {
    var title: String { get }
    
    func completeWelcome()
}
