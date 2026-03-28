import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class FirebaseAuthService {
    
    static let shared = FirebaseAuthService()
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    func register(data: RegisterData) async throws -> User {
        guard data.password.isValidPassword else {
            throw AuthError.weakPassword
        }
        
        guard data.password == data.confirmPassword else {
            throw AuthError.unknown("As senhas não coincidem")
        }
        
        do {
            let authResult = try await auth.createUser(
                withEmail: data.email,
                password: data.password
            )
            
            let user = User(
                id: authResult.user.uid,
                email: data.email,
                name: data.name,
                lastName: data.lastName,
                gender: data.gender,
                country: data.country,
                birthDate: data.birthDate,
                phoneCountryCode: data.phoneCountryCode,
                phone: data.phone,
                role: .user,
                createdAt: Date()
            )
            
            try await saveUserToFirestore(user)
            
            return user
            
        } catch let error as NSError {
            throw AuthError.from(firebaseError: error)
        }
    }
    
    func login(email: String, password: String) async throws -> User {
        do {
            let authResult = try await auth.signIn(
                withEmail: email,
                password: password
            )
            
            let user = try await fetchUserFromFirestore(userId: authResult.user.uid)
            
            return user
            
        } catch let error as NSError {
            throw AuthError.from(firebaseError: error)
        }
    }
    
    func logout() throws {
        try auth.signOut()
    }
    
    func fetchUser(userId: String) async throws -> User {
        return try await fetchUserFromFirestore(userId: userId)
    }
    
    func resetPassword(email: String) async throws {
        do {
            try await auth.sendPasswordReset(withEmail: email)
        } catch let error as NSError {
            throw AuthError.from(firebaseError: error)
        }
    }
    
    private func saveUserToFirestore(_ user: User) async throws {
        let userRef = db.collection("users").document(user.id)
        
        let userData: [String: Any] = [
            "email": user.email,
            "name": user.name,
            "lastName": user.lastName,
            "gender": user.gender.rawValue,
            "country": user.country,
            "birthDate": Timestamp(date: user.birthDate),
            "phoneCountryCode": user.phoneCountryCode,
            "phone": user.phone,
            "role": user.role == .admin ? "admin" : "user",
            "createdAt": Timestamp(date: user.createdAt)
        ]
        
        try await userRef.setData(userData)
    }
    
    private func fetchUserFromFirestore(userId: String) async throws -> User {
        let userRef = db.collection("users").document(userId)
        let document = try await userRef.getDocument()
            
        guard let data = document.data() else {
            throw AuthError.userNotFound
        }
        
        let user = User(
            id: userId,
            email: data["email"] as? String ?? "",
            name: data["name"] as? String ?? "",
            lastName: data["lastName"] as? String ?? "",
            gender: Gender(rawValue: data["gender"] as? String ?? "") ?? .preferNotToSay,
            country: data["country"] as? String ?? "",
            birthDate: (data["birthDate"] as? Timestamp)?.dateValue() ?? Date(),
            phoneCountryCode: data["phoneCountryCode"] as? String ?? "",
            phone: data["phone"] as? String ?? "",
            role: (data["role"] as? String) == "admin" ? .admin : .user,
            createdAt: (data["createdAt"] as? Timestamp)?.dateValue() ?? Date()
        )
        
        return user
    }
    
    var currrentUserId: String? {
        auth.currentUser?.uid
    }
}
