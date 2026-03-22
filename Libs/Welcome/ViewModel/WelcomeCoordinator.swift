import Foundation
import SwiftUI

@MainActor
final class WelcomeCoordinator {
    
    var onComplete: (() -> Void)?
    
    func makeWelcomeView() -> some View {
        let viewModel = WelcomeViewModel(
            authState: .shared,
            onboardingRepository: DependencyContainer.shared.onboardingRepository
        )
        
        viewModel.onComplete = { [weak self] in
            self?.onComplete?()
        }
        
        return WelcomeView(viewModel: viewModel)
    }
}
