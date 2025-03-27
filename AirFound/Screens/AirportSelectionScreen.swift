import SwiftUI

struct AirportSelectionScreen: View {
    @AppStorage("selectedAirport") var selectedAirport: String = "CPH"  // Default to "CPH"
    let airports = ["CPH - Copenhagen Airport"]
    @StateObject var itemStore = ItemStore()

    var body: some View {
        NavigationStack {
            VStack {
                Text("Select Your Airport")
                    .font(.largeTitle)
                    .bold()
                    .padding()

                // Picker for airport selection
                Picker("Select an Airport", selection: $selectedAirport) {
                    ForEach(airports, id: \.self) { airport in
                        Text(airport).tag(airport) // Tagging the airport as String
                    }
                }
                .pickerStyle(.wheel)
                .padding()

                List(airports, id: \.self) { airport in
                    Button(action: {
                        selectedAirport = airport
                    }) {
                        HStack {
                            Text(airport)
                                .font(.title2)
                            Spacer()
                            if selectedAirport == airport {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
                
                // Button to continue to Home Screen
                NavigationLink(destination: HomeScreen().environmentObject(itemStore)) {
                    Text("Continue")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
            }
            .navigationTitle("Airport Selection")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AirportSelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        AirportSelectionScreen()
    }
}
