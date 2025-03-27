import Foundation
import UIKit

class ItemStore: ObservableObject {
    @Published var items: [ItemModel] = []  // Use ItemModel instead of Item

    // Function to add a new item to the store
    func addItem(name: String, description: String, category: ItemCategory, location: String, timestamp: Date, photo: UIImage? = nil, airline: Airline? = nil, flightNumber: String? = nil, email: String? = nil) {
        let newItem = ItemModel(name: name, description: description, category: category, location: location, timestamp: timestamp, photo: photo, airline: airline, flightNumber: flightNumber, email: email)  // Use ItemModel here
        items.append(newItem)
    }
}
