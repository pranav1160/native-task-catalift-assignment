//
//  PersonalDetailsViewModel.swift
//  catalift_assignment
//
//  Created by Pranav on 10/05/25.
//


import SwiftUI
import Combine

class PersonalDetailsViewModel: ObservableObject {
    // Published properties for form fields
    @Published var fullName: String {
        didSet {
            saveToUserDefaults()
        }
    }
    
    @Published var studentID: String {
        didSet {
            saveToUserDefaults()
        }
    }
    
    @Published var selectedDay: String {
        didSet {
            saveToUserDefaults()
        }
    }
    
    @Published var selectedMonth: String {
        didSet {
            saveToUserDefaults()
        }
    }
    
    @Published var selectedYear: String {
        didSet {
            saveToUserDefaults()
        }
    }
    
    @Published var motherTongue: String {
        didSet {
            saveToUserDefaults()
        }
    }
    
    @Published var gender: String {
        didSet {
            saveToUserDefaults()
        }
    }
    
    @Published var phoneNumber: String {
        didSet {
            saveToUserDefaults()
        }
    }
    
    @Published var emailAddress: String {
        didSet {
            saveToUserDefaults()
        }
    }
    
    @Published var linkedIn: String {
        didSet {
            saveToUserDefaults()
        }
    }
    
  
    
    enum UserDefaultsKeys: String, CaseIterable {
        case fullName
        case studentID
        case selectedDay
        case selectedMonth
        case selectedYear
        case motherTongue
        case gender
        case phoneNumber
        case emailAddress
        case linkedIn
    }

    
    // Initialize with values from UserDefaults
    init() {
        let defaults = UserDefaults.standard
        
        self.fullName = defaults
            .string(forKey: UserDefaultsKeys.fullName.rawValue) ?? ""
        self.studentID = defaults
            .string(forKey: UserDefaultsKeys.studentID.rawValue) ?? ""
        self.selectedDay = defaults
            .string(forKey: UserDefaultsKeys.selectedDay.rawValue) ?? ""
        self.selectedMonth = defaults
            .string(forKey: UserDefaultsKeys.selectedMonth.rawValue) ?? ""
        self.selectedYear = defaults.string(forKey: UserDefaultsKeys.selectedYear.rawValue) ?? ""

        self.motherTongue = defaults
            .string(forKey: UserDefaultsKeys.motherTongue.rawValue) ?? "English"
        self.gender = defaults
            .string(forKey: UserDefaultsKeys.gender.rawValue) ?? "Male"
        self.phoneNumber = defaults
            .string(forKey: UserDefaultsKeys.phoneNumber.rawValue) ?? ""
        self.emailAddress = defaults
            .string(forKey: UserDefaultsKeys.emailAddress.rawValue) ?? ""
        self.linkedIn = defaults
            .string(forKey: UserDefaultsKeys.linkedIn.rawValue) ?? ""
    }
    
    // Save all data to UserDefaults
    private func saveToUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(fullName, forKey: UserDefaultsKeys.fullName.rawValue)
        defaults.set(studentID, forKey: UserDefaultsKeys.studentID.rawValue)
        defaults.set(selectedDay, forKey: UserDefaultsKeys.selectedDay.rawValue)
        defaults.set(selectedMonth, forKey: UserDefaultsKeys.selectedMonth.rawValue)
        defaults.set(selectedYear, forKey: UserDefaultsKeys.selectedYear.rawValue)
        defaults.set(motherTongue, forKey: UserDefaultsKeys.motherTongue.rawValue)
        defaults.set(gender, forKey: UserDefaultsKeys.gender.rawValue)
        defaults.set(phoneNumber, forKey: UserDefaultsKeys.phoneNumber.rawValue)
        defaults.set(emailAddress, forKey: UserDefaultsKeys.emailAddress.rawValue)
        defaults.set(linkedIn, forKey: UserDefaultsKeys.linkedIn.rawValue)
    }

    
    // Check if all required fields are filled
    var isFormValid: Bool {
        let requiredFields = [
            fullName.trimmingCharacters(in: .whitespacesAndNewlines),
            selectedDay,
            selectedMonth,
            selectedYear,
            motherTongue,
            gender,
            phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines),
            emailAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        ]
        
        return requiredFields.allSatisfy { !$0.isEmpty }
    }
    
    // Email validation
    var isEmailValid: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailAddress.isEmpty || emailPredicate.evaluate(with: emailAddress)
    }
    
    // Phone validation (basic check for now)
    var isPhoneValid: Bool {
        return phoneNumber.isEmpty || phoneNumber.count >= 10
    }
    
    // Clear all form data
    func clearFormData() {
        fullName = ""
        studentID = ""
        selectedDay = ""
        selectedMonth = ""
        selectedYear = ""
        motherTongue = "English"
        gender = "Male"
        phoneNumber = ""
        emailAddress = ""
        linkedIn = ""
        
        let defaults = UserDefaults.standard
        UserDefaultsKeys.allCases.forEach { key in
            defaults.removeObject(forKey: key.rawValue)
        }
    }

}
