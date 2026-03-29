import Foundation
import SwiftUI
import Combine

class CheckoutCoordinator: ObservableObject {
    
    enum CheckoutRoute: Hashable {
        case form
        case review
        case success
    }
    
    @Published var path = NavigationPath()
    let checkoutViewModel = CheckoutViewModel()
    
    @ViewBuilder
    func build(route: CheckoutRoute) -> some View {
        switch route {
        case .form:
            CheckoutFormView(checkoutViewModel: checkoutViewModel)
        case .review:
            CheckoutReviewView(checkoutViewModel: checkoutViewModel)
        case .success:
            SuccessView()
        }
    }
    
    func finishFlow() {
        path.removeLast(path.count)
    }
}
