import SwiftUI
import GoogleSignInSwift

struct RegistrationView: View {
    
    
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var googleAuthVM :GoogleAuthViewModel
    @State private var isNavigatingToPersonalDetails = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack(spacing: 24) {
                    Spacer()
                    
                    // CATALIFT logo
                    HStack(spacing: 0) {
                        Text("CATA").bold()
                        Text("LIFT")
                            .overlay(
                                Rectangle()
                                    .frame(height: 3)
                                    .offset(y: -3),
                                alignment: .top
                            )
                    }
                    .font(.largeTitle)
                    .foregroundStyle(.appBlue)
                    .tracking(6)
                    
                    Text("Register to boost your career!")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.appBlue)
                    
                    VStack(spacing: 24) {
                        HStack {
                            Text("Sign-Up")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                            Button("Privacy Policy") {
                                // Action
                            }
                            .foregroundColor(.appBlue)
                            .underline()
                        }
                        .padding(.bottom, 12)
                        
                        CustomTextField(placeholder: "Full Name", text: $authVM.fullName)
                        CustomTextField(placeholder: "Phone Number", text: $authVM.phoneNumber, keyboardType: .phonePad)
                        CustomTextField(placeholder: "Email Address", text: $authVM.currEmail, keyboardType: .emailAddress)
                            .textInputAutocapitalization(.never)
                        CustomTextField(placeholder: "Password", text: $authVM.currPassword, isSecure: true)
                            .textInputAutocapitalization(.never)
                        
                        VStack {
                            GoogleSignInButton(action: googleAuthVM.signIn)
                                .frame(width: 200, height: 50)
                        }
                        .onChange(of: googleAuthVM.state) { newState in
                            if newState == .signedIn {
                                isNavigatingToPersonalDetails = true
                            }
                        }

                        
                        Button(action: {
                            authVM.signUp()
                        }) {
                            Text("Create Account")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.appBlue)
                                .cornerRadius(10)
                        }
                        .padding(.top, 12)
                        
                        HStack(spacing: 4) {
                            Text("Already have an account?")
                                .foregroundColor(Color.gray.opacity(0.7))
                            NavigationLink(destination: LoginView()) {
                                Text("Sign-In")
                                    .foregroundColor(.appBlue)
                                    .fontWeight(.medium)
                            }
                        }
                        .padding(.top, 12)
                    }
                    .padding()
                    
                    Spacer()
                }
                .disabled(authVM.isLoading)
                .blur(radius: authVM.isLoading ? 2 : 0)
            }
            
            // Loader Overlay
            if authVM.isLoading {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                ProgressView("Creating Account...")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
            }
        }
        .onChange(of: authVM.isAuthenticated) { isAuthenticated in
            if isAuthenticated {
                dismiss()
            }
        }

        .animation(.easeInOut, value: authVM.isLoading)
    }

}

#Preview {
    RegistrationView()
        .environmentObject(AuthViewModel())
        .environmentObject(GoogleAuthViewModel())
}
