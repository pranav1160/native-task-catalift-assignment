//
//  HomeView.swift
//  catalift_assignment
//
//  Created by Pranav on 10/05/25.
//

import SwiftUI


struct PersonalDetailsView: View {
    @EnvironmentObject var authVM:AuthViewModel
    // ViewModel
    @StateObject private var viewModel = PersonalDetailsViewModel()
    
    // Dropdown options
    let languages = ["English", "Hindi", "Spanish", "French", "Chinese", "Arabic"]
    let genders = ["Male", "Female", "Non-binary", "Prefer not to say"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
               
                
                // Title
                Text("Your Personal Details")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.appBlue)
                    .padding(.top, 20)
                
                // Full Name Field (with asterisk)
                HStack(alignment: .firstTextBaseline) {
                    Text("Full Name")
                        .foregroundColor(.appBlue)
                        .fontWeight(.medium)
                    
                    Text("*")
                        .foregroundColor(.red)
                }
                
                TextField("", text: $viewModel.fullName)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                
                // Student ID Field
                Text("Student ID")
                    .foregroundColor(.appBlue)
                    .fontWeight(.medium)
                
                TextField("", text: $viewModel.studentID)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                
                // DOB Field (with asterisk)
                HStack(alignment: .firstTextBaseline) {
                    Text("DOB")
                        .foregroundColor(.appBlue)
                        .fontWeight(.medium)
                    
                    Text("*")
                        .foregroundColor(.red)
                }
                
                // DOB Dropdown fields (day, month, year)
                HStack(spacing: 12) {
                    // Day picker
                    Menu {
                        ForEach(1...31, id: \.self) { day in
                            Button("\(day)") {
                                viewModel.selectedDay = "\(day)"
                            }
                        }
                    } label: {
                        HStack {
                            Text(viewModel.selectedDay.isEmpty ? "" : viewModel.selectedDay)
                                .foregroundColor(viewModel.selectedDay.isEmpty ? .gray.opacity(0.7) : .black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .foregroundColor(.appBlue)
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                    
                    // Month picker
                    Menu {
                        ForEach(1...12, id: \.self) { month in
                            Button("\(month)") {
                                viewModel.selectedMonth = "\(month)"
                            }
                        }
                    } label: {
                        HStack {
                            Text(viewModel.selectedMonth.isEmpty ? "" : viewModel.selectedMonth)
                                .foregroundColor(viewModel.selectedMonth.isEmpty ? .gray.opacity(0.7) : .black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .foregroundColor(.appBlue)
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                    
                    // Year picker
                    Menu {
                        ForEach((1950...2024).reversed(), id: \.self) { year in
                            Button("\(year)") {
                                viewModel.selectedYear = "\(year)"
                            }
                        }
                    } label: {
                        HStack {
                            Text(viewModel.selectedYear.isEmpty ? "" : viewModel.selectedYear)
                                .foregroundColor(viewModel.selectedYear.isEmpty ? .gray.opacity(0.7) : .black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.down")
                                .foregroundColor(.appBlue)
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                }
                
                // Mother Tongue Field (with asterisk)
                HStack(alignment: .firstTextBaseline) {
                    Text("Mother Tongue")
                        .foregroundColor(.appBlue)
                        .fontWeight(.medium)
                    
                    Text("*")
                        .foregroundColor(.red)
                }
                
                // Mother Tongue dropdown
                Menu {
                    ForEach(languages, id: \.self) { language in
                        Button(language) {
                            viewModel.motherTongue = language
                        }
                    }
                } label: {
                    HStack {
                        Text(viewModel.motherTongue)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.appBlue)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
                
                // Gender Field (with asterisk)
                HStack(alignment: .firstTextBaseline) {
                    Text("Gender")
                        .foregroundColor(.appBlue)
                        .fontWeight(.medium)
                    
                    Text("*")
                        .foregroundColor(.red)
                }
                
                // Gender dropdown
                Menu {
                    ForEach(genders, id: \.self) { genderOption in
                        Button(genderOption) {
                            viewModel.gender = genderOption
                        }
                    }
                } label: {
                    HStack {
                        Text(viewModel.gender)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.appBlue)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
                
                // Phone Number Field (with asterisk)
                HStack(alignment: .firstTextBaseline) {
                    Text("Phone Number")
                        .foregroundColor(.appBlue)
                        .fontWeight(.medium)
                    
                    Text("*")
                        .foregroundColor(.red)
                }
                
                TextField("", text: $viewModel.phoneNumber)
                    .padding()
                    .keyboardType(.phonePad)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(viewModel.isPhoneValid ? Color.gray.opacity(0.3) : Color.red, lineWidth: 1)
                    )
                
                // Show error if phone is invalid
                if !viewModel.isPhoneValid && !viewModel.phoneNumber.isEmpty {
                    Text("Please enter a valid phone number")
                        .font(.caption)
                        .foregroundColor(.red)
                }
                
                // Email Address Field (with asterisk)
                HStack(alignment: .firstTextBaseline) {
                    Text("Email Address")
                        .foregroundColor(.appBlue)
                        .fontWeight(.medium)
                    
                    Text("*")
                        .foregroundColor(.red)
                }
                
                TextField("", text: $viewModel.emailAddress)
                    .padding()
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(viewModel.isEmailValid ? Color.gray.opacity(0.3) : Color.red, lineWidth: 1)
                    )
                
                // Show error if email is invalid
                if !viewModel.isEmailValid && !viewModel.emailAddress.isEmpty {
                    Text("Please enter a valid email address")
                        .font(.caption)
                        .foregroundColor(.red)
                }
                
                // LinkedIn Field
                Text("LinkedIn")
                    .foregroundColor(.appBlue)
                    .fontWeight(.medium)
                
                TextField("", text: $viewModel.linkedIn)
                    .padding()
                    .autocapitalization(.none)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                
                // Add a Save button
                Button(action: {
                    // This will automatically save the form via didSet in the ViewModel
                    print("Form data saved to UserDefaults")
                }) {
                    Text("Save Details")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.isFormValid ? Color.appBlue : Color.gray)
                        .cornerRadius(8)
                }
                .disabled(!viewModel.isFormValid)
                .padding(.top, 20)
                
                // Debug button to clear data (can be removed in production)
                Button("Clear All Data") {
                    viewModel.clearFormData()
                }
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 4)
                .frame(maxWidth: .infinity, alignment: .center)
                
              
                    Button(action: {
                        authVM.signOut()
                        
                    }) {
                        Text("Logout")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding()
                
             
                
                // Add some bottom padding
                Spacer()
                    .frame(height: 40)
            }
            .padding(.horizontal)
        }
    }
}



#Preview {
    PersonalDetailsView()
        .environmentObject(AuthViewModel())
}
