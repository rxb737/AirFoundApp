import SwiftUI

@main
struct AirFoundApp: App {
    @StateObject private var itemStore = ItemStore()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeScreen()
                    .environmentObject(itemStore)  // Pass ItemStore to all child views
            }
        }
    }
}
