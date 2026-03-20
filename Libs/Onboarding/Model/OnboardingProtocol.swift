import Foundation

protocol OnboardingCoordinatorProtocol: AnyObject {
    func start()
    func finishOnboarding()
    func showNextPage()
}

protocol OnboardingViewModelProtocol : ObservableObject {
    var currentPage: Int { get }
    var pages: [OnboardingPageModel] { get }
    var isLoading: Bool { get set }
    
    func nextPage()
    func requestPermission()
}

protocol PermissionServiceProtocol {
    func requestNotificationPermission() async -> Bool
    func requestTrackingPermission() async -> Bool
    func requestLocationPermission() async -> Bool
}

protocol OnboardingRepositoryProtocol {
    func makeOnboardingAsCompleted()
    func hasCompletedOnboarding() -> Bool
}


