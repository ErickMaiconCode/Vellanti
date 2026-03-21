import Foundation
import SwiftUI

final class AuthGatewayCoordinator {
    
    private let showContinueWithoutLogin: Bool
    
    var onLoginTapped: (() -> Void)?
    var onRegisterTapped: (() -> Void)?
    var onContinueWithoutLogin: (() -> Void)?
    
    init(showContinueWithoutLogin: Bool = true ) {
        self.showContinueWithoutLogin = showContinueWithoutLogin
    }
    
    func makeAuthGatewayView() -> some View {
        let viewModel = AuthGatewayViewModel(showContinueWithoutLogin: showContinueWithoutLogin)
        
        viewModel.onLoginTapped = { [ weak self ]  in
            self?.onLoginTapped?()
        }
        
        viewModel.onRegisterTapped = { [ weak self ] in
            self?.onRegisterTapped?()
        }
        
        viewModel.onContinueWithoutLogin = { [ weak self ] in
            self?.onContinueWithoutLogin?()
        }
        
        return AuthGatewayView(viewModel: viewModel)
    }
}
