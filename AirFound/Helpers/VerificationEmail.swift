import Foundation
import SwiftSMTP

var storedVerificationCode: String? // Store the verification code temporarily

struct VerificationManager {
    static let verifiedEmailsKey = "VerifiedEmails"

    static func markEmailAsVerified(_ email: String) {
        var verifiedEmails = getVerifiedEmails()
        if !verifiedEmails.contains(email) {
            verifiedEmails.append(email)
            UserDefaults.standard.set(verifiedEmails, forKey: verifiedEmailsKey)
        }
    }

    static func isEmailVerified(_ email: String) -> Bool {
        let verifiedEmails = getVerifiedEmails()
        return verifiedEmails.contains(email)
    }

    private static func getVerifiedEmails() -> [String] {
        return UserDefaults.standard.stringArray(forKey: verifiedEmailsKey) ?? []
    }
}

func sendVerificationEmail(to email: String) {
    let smtp = SMTP(
        hostname: "smtp.gmail.com",
        email: "airfoundapp@gmail.com",
        password: "ekdzfhgrdcseiawm"  // Make sure this is your correct App Password
    )
    
    let from = Mail.User(name: "Your App", email: "airfoundapp@gmail.com")
    let to = Mail.User(name: "User", email: email)
    
    // Generate a random 6-digit verification code
    let verificationCode = String(format: "%06d", Int.random(in: 0..<1000000))
    
    // Save the verification code
    storedVerificationCode = verificationCode
    
    let mail = Mail(from: from, to: [to], subject: "Verification Code", text: "Here is your verification code: \(verificationCode)")

    smtp.send(mail) { error in
        if let error = error {
            print("Failed to send email: \(error)")
        } else {
            print("Email sent successfully!")
        }
    }
}
