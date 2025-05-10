import SwiftUI
import GoogleSignInSwift

struct LoginView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @State private var isNavigatingToRegistration = false
    @StateObject var authViewModel = GoogleAuthViewModel()
    @State private var isNavigatingToPersonalDetails = false
    @EnvironmentObject var googleAuthVM: GoogleAuthViewModel

    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                
                Image(.cataliftTaskLogin)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                
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
                
                Text("Give your career an EXTRA boost")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.appBlue)
                
                VStack(spacing: 24) {
                    HStack {
                        Text("Sign-In")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button("Privacy Policy") {
                            // Privacy policy action
                        }
                        .foregroundColor(.appBlue)
                        .underline()
                    }
                    .padding(.bottom, 12)
                    
                    // Use custom text fields here
                    CustomTextField(
                        placeholder: "Email",
                        text: $authVM.currEmail,
                        keyboardType: .phonePad
                    )
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    
                    CustomTextField(
                        placeholder: "Password",
                        text: $authVM.currPassword,
                        isSecure: true
                    )
                    .autocapitalization(.none)
                    
                    HStack {
                        Spacer()
                        Button("Forgot Password?") {
                            // Forgot password action
                        }
                        .foregroundColor(Color.gray.opacity(0.7))
                    }
                    .padding(.top, -8)
                    
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
                        authVM.signIn()
                    }) {
                        Text("Sign-In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.appBlue)
                            .cornerRadius(10)
                    }
                    .padding(.top, 12)
                    
                    // Sign-up Navigation Button
                    NavigationLink(destination: RegistrationView()) {
                        HStack(spacing: 4) {
                            Text("Don't Have An Account?")
                                .foregroundColor(Color.gray.opacity(0.7))
                            
                            Text("Sign-Up")
                                .foregroundColor(.appBlue)
                                .fontWeight(.medium)
                        }
                        .padding(.top, 12)
                    }
                }
                .padding()
                
                Spacer()
            }
            .ignoresSafeArea()
            .disabled(authVM.isLoading) // prevent interaction
            .blur(radius: authVM.isLoading ? 2 : 0)
            
            if authVM.isLoading {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                ProgressView("Signing In...")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
            }
            
        }
      

        .animation(.easeInOut, value: authVM.isLoading)
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
        .environmentObject(GoogleAuthViewModel())
}
