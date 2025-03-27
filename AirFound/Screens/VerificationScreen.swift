import SwiftUI

struct VerificationScreen: View {
    var email: String // This will receive the email from the FlightInfoScreen
    
    @State private var verificationCode = ""
    @State private var verificationStatus: String = ""
    @State private var isVerified = false
    
    // Explicit initializer for the struct
    init(email: String) {
        self.email = email
    }

    var body: some View {
        Form {
            if isVerified {
                Section {
                    Text("Email already verified!")
                        .foregroundColor(.green)
                        .font(.headline)
                        .padding()
                }
                Button("Continue") {
                    // Navigate to the next screen
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            } else {
                Section(header: Text("Enter your verification code")) {
                    Text("We sent a verification code to \(email)")
                        .padding()
                    
                    TextField("Verification Code", text: $verificationCode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                }
                
                Button(action: verifyEmail) {
                    Text("Verify")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Text(verificationStatus)
                    .foregroundColor(verificationStatus == "Verification successful!" ? .green : .red)
                    .padding()
            }
        }
        .navigationTitle("Verification")
        .onAppear {
            checkIfVerified()
        }
    }

    private func checkIfVerified() {
        if VerificationManager.isEmailVerified(email) {
            isVerified = true
        }
    }

    func verifyEmail() {
        // Check if the entered verification code matches the stored one
        guard !verificationCode.isEmpty else {
            verificationStatus = "Please enter the verification code."
            return
        }

        if verificationCode == storedVerificationCode {
            verificationStatus = "Verification successful!"
            VerificationManager.markEmailAsVerified(email)
            isVerified = true
        } else {
            verificationStatus = "Incorrect verification code. Please try again."
        }
    }
}

struct VerificationScreen_Previews: PreviewProvider {
    static var previews: some View {
        VerificationScreen(email: "test@example.com")
    }
}
