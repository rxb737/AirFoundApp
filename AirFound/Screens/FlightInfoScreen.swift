import SwiftUI

struct FlightInfoScreen: View {
    @EnvironmentObject var itemStore: ItemStore
    var item: ItemModel

    @State private var selectedAirline: Airline = .other
    @State private var flightNumber = ""
    @State private var email = ""
    @State private var isEmailVerified = false

    var body: some View {
        Form {
            Section(header: Text("Flight Information")) {
                Picker("Airline", selection: $selectedAirline) {
                    ForEach(Airline.allCases, id: \ .self) { airline in
                        Text(airline.rawValue).tag(airline)
                    }
                }
                .pickerStyle(MenuPickerStyle())

                TextField("Flight Number", text: $flightNumber)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .onChange(of: email) {
                        checkIfEmailVerified(email)
                    }

            }

            if isEmailVerified {
                Text("Email verified!")
                    .foregroundColor(.green)
                    .font(.headline)
                    .padding()
            } else {
                NavigationLink(destination: VerificationScreen(email: email)) {
                    Text("Verify")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .navigationTitle("Flight Info")
    }

    private func checkIfEmailVerified(_ email: String) {
        isEmailVerified = VerificationManager.isEmailVerified(email)
    }
}

struct FlightInfoScreen_Previews: PreviewProvider {
    static var previews: some View {
        FlightInfoScreen(item: ItemModel(name: "Laptop", description: "A laptop", category: .electronics, location: "Gate 12", timestamp: Date(), airline: .sas, flightNumber: "AB1234", email: "test@example.com"))
            .environmentObject(ItemStore())
    }
}
