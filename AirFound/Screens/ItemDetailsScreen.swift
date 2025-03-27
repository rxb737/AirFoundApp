import SwiftUI

struct ItemDetailsScreen: View {
    @EnvironmentObject var itemStore: ItemStore // Access the ItemStore
    
    let item: ItemModel  // The selected item passed from the previous screen
    
    var body: some View {
        VStack {
            // Display the item details
            Text(item.name)
                .font(.largeTitle)
                .padding()
            
            Text(item.description)
                .font(.body)
                .padding()

            if let photo = item.photo {
                Image(uiImage: photo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding()
            }

            Text("Category: \(item.category.rawValue)")
                .font(.headline)
                .padding()
            
            Text("Location: \(item.location)")
                .font(.subheadline)
                .padding()

            Text("Reported on: \(item.timestamp, style: .date)")
                .font(.caption)
                .padding()

            Spacer()
        }
        .navigationBarTitle("Item Details", displayMode: .inline)
    }
}

struct ItemDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        // Here we create a dummy ItemModel to display in the preview
        ItemDetailsScreen(item: ItemModel(name: "Sample Item", description: "This is a sample item", category: .electronics, location: "Gate A", timestamp: Date(), photo: nil))
            .environmentObject(ItemStore())  // Provide the ItemStore in the preview
    }
}
