import Foundation
import Combine

@MainActor
final class AuthState: ObservableObject {
    
    static let shared = AuthState()
    
    @Published private(set) var isAuthenticated: Bool = false
    @Published private(set) var currentUser: User?
    @Published var isLoading: Bool = false
    @Published var error: ErrorType?
    
    private let firebaseService = FirebaseAuthService.shared
    private let coreDataService = CoreDataSyncService.shared
    
    private init() {
        restoreSession()
    }

    func login(email: String, password: String) async throws {
        isLoading = true
        error = nil
        defer { isLoading = false }
        
        do {
            let user = try await firebaseService.login(email: email, password: password)
            self.currentUser = user
            self.isAuthenticated = true
            
            await coreDataService.syncUserData(userId: user.id)
            
        } catch let authError as AuthError {
            
            let errorType = authError.toErrorType()
            self.error = errorType
            throw authError
            
        } catch {
            
            let errorType = ErrorType.authGeneric("Erro ao fazer login")
            self.error = errorType
            throw error
        }
    }
    
    func register(data: RegisterData) async throws {
        isLoading = true
        error = nil
        defer { isLoading = false }
        
        do {
            let user = try await firebaseService.register(data: data)
            self.currentUser = user
            self.isAuthenticated = true
            
            await coreDataService.syncUserData(userId: user.id)
            
        } catch let authError as AuthError {
            
            let errorType = authError.toErrorType()
            self.error = errorType
            throw authError
            
        } catch {
            
            let errorType = ErrorType.authGeneric("Erro ao criar conta")
            self.error = errorType
            throw error
        }
    }
    
    func logout() {
        do {
            try firebaseService.logout()
            coreDataService.clearLocalData()
            
            self.currentUser = nil
            self.isAuthenticated = false
            self.error = nil
        } catch {
            print("Logou error: \(error)")
        }
    }

    func updateUser(_ user: User) {
        guard isAuthenticated else { return }
        self.currentUser = user
    }

    private func restoreSession() {
        guard let userId = firebaseService.currrentUserId else { return }
        
        isLoading = true
        
        Task {
            do {
                let user = try await firebaseService.fetchUser(userId: userId)
                self.currentUser = user
                self.isAuthenticated = true
                
                await coreDataService.syncUserData(userId: userId)
                
            } catch {
                try? firebaseService.logout()
            }
            
            isLoading = false
        }
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
