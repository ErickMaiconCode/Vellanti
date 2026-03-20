import SwiftUI

protocol SplashCoordinatorProtocol: AnyObject {
    func start()
    func splashDidFinish()
}

protocol SplashViewModelProtocol: ObservableObject {
    var isLogoVisible: Bool { get set }
    var shouldZoom: Bool { get set }
    var isTransitionComplete: Bool { get set }
    
    func startAnimationSequence()
}
