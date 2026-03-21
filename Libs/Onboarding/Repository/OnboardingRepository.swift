import Foundation

final class OnboardingRepository: OnboardingRepositoryProtocol {
    private let userDefaults: UserDefaults
    
    private enum UserDefaultsKeys {
        static let hasCompletedOnboarding = "hasCompletedOnboarding"
        static let hasSeenWelcome = "hasSeenWelcome"
    }
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func makeOnboardingAsCompleted() {
        userDefaults.set(true, forKey: UserDefaultsKeys.hasCompletedOnboarding)
    }
    
    func hasCompletedOnboarding() -> Bool {
        return userDefaults.bool(forKey: UserDefaultsKeys.hasCompletedOnboarding)
    }
    
    func markWelcomeAsSeen() {
        userDefaults.set(true, forKey: UserDefaultsKeys.hasSeenWelcome)
    }
    
    func hasSeenWelcome() -> Bool {
        return userDefaults.bool(forKey: UserDefaultsKeys.hasSeenWelcome)
    }
    
}
