import Foundation
import FirebaseAuth

/// ViewModel to manage authentication state and actions.
final class AuthViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var currEmail: String = ""
    @Published var currPassword: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var authError: String? = nil
    @Published var isLoading: Bool = false
    
    @Published var fullName: String = ""
    @Published var phoneNumber: String = ""
    
    private let authService = AuthService.shared
    
    
    func signIn() {
        print("[DEBUG] Starting signIn()")
        print("[DEBUG] Email: \(currEmail), Password: \(currPassword)")
        
        isLoading = true
        authService.signIn(email: currEmail, password: currPassword) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let user):
                    print("[DEBUG] Sign in successful for user: \(user.email ?? "Unknown Email")")
                    self?.isAuthenticated = true
                    self?.authError = nil
                case .failure(let error):
                    print("[DEBUG] Sign in failed: \(error.localizedDescription)")
                    self?.authError = error.localizedDescription
                }
            }
        }
    }
    
    func signUp() {
        print("[DEBUG] Starting signUp()")
        print("[DEBUG] Email: \(currEmail), Password: \(currPassword)")
        
        isLoading = true
        authService.signUp(email: currEmail, password: currPassword) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let user):
                    print("[DEBUG] Sign up successful for user: \(user.email ?? "Unknown Email")")
                    self?.isAuthenticated = true
                    self?.authError = nil
                case .failure(let error):
                    print("[DEBUG] Sign up failed: \(error.localizedDescription)")
                    self?.authError = error.localizedDescription
                }
            }
        }
    }
    
    func signOut() {
        print("[DEBUG] Attempting sign out")
        
        do {
            try authService.signOut()
            DispatchQueue.main.async {
                print("[DEBUG] Sign out successful")
                self.isAuthenticated = false
            }
        } catch {
            print("[DEBUG] Sign out failed: \(error.localizedDescription)")
            authError = error.localizedDescription
        }
    }
}
