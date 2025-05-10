//
//  GoogleAuthModel.swift
//  catalift_assignment
//
//  Created by Pranav on 10/05/25.
//

import GoogleSignIn
import GoogleSignInSwift // For SwiftUI button
import FirebaseAuth

class GoogleAuthViewModel : ObservableObject {
    enum SignInState {
        case signedIn
        case signedOut
    }
    @Published var state: SignInState = .signedOut
    
    func signIn() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else { return }
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { signInResult, error in
            guard let user = signInResult?.user, error == nil else {
                // Handle error
                return
            }
            guard let idToken = user.idToken?.tokenString else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result, error in
                if let _ = result {
                    DispatchQueue.main.async {
                        self.state = .signedIn
                    }
                } else {
                    // Handle error
                }
            }
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.state = .signedOut
    }
}
