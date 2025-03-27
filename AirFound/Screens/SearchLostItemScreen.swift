import SwiftUI

struct SearchLostItemScreen: View {
    @EnvironmentObject var itemStore: ItemStore
    @State private var searchText = ""
    @State private var flightNumber = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var showingDetails = false
    @State private var selectedItem: ItemModel?

    var body: some View {
        VStack {
            Text("AirFound CPH")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
                .foregroundColor(.blue)
            
            TextField("Search for an item (e.g., bag, laptop, wallet)", text: $searchText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            VStack {
                ForEach(filteredItems) { item in
                    NavigationLink(value: item) {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("Reported on: \(formattedDate(item.timestamp))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(item.photo != nil ? "Picture Available" : "No Picture Available")
                                .font(.caption)
                                .foregroundColor(item.photo != nil ? .green : .red)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    }
                    .padding(.vertical, 5)
                }
            }

            if showingDetails {
                VStack {
                    Text("Verify Your Information")
                        .font(.headline)
                    
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
                        showingDetails = false
                    }) {
                        Text("Verify")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Search Lost Items")
        .navigationDestination(for: ItemModel.self) { item in
            ItemDetailsScreen(item: item)
        }
    }

    var filteredItems: [ItemModel] {
        itemStore.items.filter { item in
            searchText.isEmpty ||
            item.name.lowercased().contains(searchText.lowercased()) ||
            item.description.lowercased().contains(searchText.lowercased()) ||
            item.category.rawValue.lowercased().contains(searchText.lowercased())
        }
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct SearchLostItemScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearchLostItemScreen().environmentObject(ItemStore())
    }
}
