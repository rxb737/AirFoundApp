import SwiftUI

struct HomeScreen: View {
    @State private var selectedAirport: String? = "CPH" // Set default to CPH for now

    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to AirFound")
                    .font(.largeTitle)
                    .bold()
                    .padding()

                // Remove the airport picker
                Text("You are currently at \(selectedAirport ?? "Unknown") Airport")
                    .font(.headline)
                    .padding()

                // Report Item Button
                NavigationLink(value: "Report Item") {
                    Text("Report Found Item")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                // Search Lost Item Button
                NavigationLink(value: "Search Lost Item") {
                    Text("Search Lost Item")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Home")
            .navigationDestination(for: String.self) { value in
                if value == "Report Item" {
                    ReportFoundItemScreen().environmentObject(ItemStore())
                } else if value == "Search Lost Item" {
                    SearchLostItemScreen() // Add this screen if not created yet
                }
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

