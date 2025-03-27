import SwiftUI

struct GuidanceScreen: View {
    @State private var flightNumber = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var isVerified = false

    var body: some View {
        VStack {
            if !isVerified {
                Text("Please enter your details to proceed:")
                    .font(.headline)
                    .padding()

                TextField("Flight Number", text: $flightNumber)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Email", text: $email)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Phone Number", text: $phoneNumber)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    // Verify the details and show further instructions
                    if flightNumber == "expectedFlight" { // Replace with actual verification
                        isVerified = true
                    }
                }) {
                    Text("Verify")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            } else {
                Text("Thank you for verifying. Please proceed to the lost and found handler.")
                    .padding()
                // Show information to contact lost and found based on item location
            }
        }
        .navigationTitle("Guidance")
        .padding()
    }
}
