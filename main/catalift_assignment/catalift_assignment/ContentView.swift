//
//  ContentView.swift
//  catalift_assignment
//
//  Created by Pranav on 10/05/25.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var authVM:AuthViewModel
    @EnvironmentObject var googleAuthVM:GoogleAuthViewModel
    var body: some View {
        NavigationStack {
            if authVM.isAuthenticated || googleAuthVM.state == .signedIn {
                PersonalDetailsView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            // Check authentication status when the app loads
            if let _ = Auth.auth().currentUser {
                authVM.isAuthenticated = true
                authVM.currEmail = Auth.auth().currentUser?.email ?? ""
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
        .environmentObject(GoogleAuthViewModel())
}
