import SwiftUI

struct ContentView: View {
    @StateObject private var itemStore = ItemStore()

    var body: some View {
        NavigationView {
            ReportFoundItemScreen()
                .environmentObject(itemStore) // Pass the environment object to the ReportFoundItemScreen
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

