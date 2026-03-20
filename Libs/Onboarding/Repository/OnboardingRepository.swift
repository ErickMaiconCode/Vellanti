import Foundation

final class OnboardingRepository: OnboardingRepositoryProtocol {
    private let userDefaults: UserDefaults
    private let onboardingKey = "hasCompletedOnboarding"
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func makeOnboardingAsCompleted() {
        userDefaults.set(true, forKey: onboardingKey)
    }
    
    func hasCompletedOnboarding() -> Bool {
        return userDefaults.bool(forKey: onboardingKey)
    }
    
    
}
