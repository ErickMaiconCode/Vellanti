import Foundation
import Combine

@MainActor
final class AuthState: ObservableObject {
    
    static let shared = AuthState()
    
    @Published private(set) var isAuthenticated: Bool = false
    @Published private(set) var currentUser: User?

    private enum Keys {
        static let currentUserId = "currentUserId"
    }
    
    private let userDefaults: UserDefaults
    
    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
 
        restoreSession()
    }
    
    func login(user: User) {
        self.currentUser = user
        self.isAuthenticated = true
        
        userDefaults.set(user.id, forKey: Keys.currentUserId)
    }

    func logout() {
        self.currentUser = nil
        self.isAuthenticated = false
        userDefaults.removeObject(forKey: Keys.currentUserId)
    }

    func updateUser(_ user: User) {
        guard isAuthenticated else {
            return
        }
        
        self.currentUser = user
    }

    private func restoreSession() {
        guard let userId = userDefaults.string(forKey: Keys.currentUserId) else {
            return
        }
        
        // TODO: Buscar usuário do Firebase/Firestore usando o userId
        print("🔐 AuthState: Found saved userId: \(userId) - TODO: Restore from Firebase")
        
        // Quando implementar Firebase:
        // Task {
        //     do {
        //         let user = try await firebaseService.fetchUser(userId: userId)
        //         login(user: user)
        //     } catch {
        //         print("🔐 AuthState: Failed to restore session - \(error)")
        //         userDefaults.removeObject(forKey: Keys.currentUserId)
        //     }
        // }
    }
    
    var currentUserId: String? {
        currentUser?.id
    }
    
    var isAdmin: Bool {
        currentUser?.isAdmin ?? false
    }
    
    var displayName: String {
        currentUser?.fullName ?? "Visitante"
    }
    
    var formalGreeting: String {
        currentUser?.formalGreeting ?? "Visitante"
    }
}
