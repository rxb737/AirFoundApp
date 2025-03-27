import SwiftUI
import AVFoundation
import Photos

struct ReportFoundItemScreen: View {
    @EnvironmentObject var itemStore: ItemStore
    @State private var itemName = ""
    @State private var itemDescription = ""
    @State private var selectedCategory: ItemCategory = .other
    @State private var location = ""
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var showConfirmation = false
    @State private var showPermissionAlert = false
    @State private var permissionMessage = ""
    @State private var imagePickerSource: UIImagePickerController.SourceType?

    var body: some View {
        Form {
            Section {
                TextField("Item Name", text: $itemName)
                TextField("Description (e.g., Brand, Color)", text: $itemDescription)
                Picker("Category", selection: $selectedCategory) {
                    ForEach(ItemCategory.allCases) { category in
                        Text(category == .documents ? "Document/Passport" : category.rawValue)
                            .tag(category)
                    }
                }
            } header: {
                Text("Item Details")
            }

            Section {
                TextField("Found Location (e.g., Gate B5, Shop 12)", text: $location)
            } header: {
                Text("Location")
            }

            Section {
                Button("Add Photo") {
                    if selectedCategory != .documents {
                        presentImageOptions()
                    }
                }
                .disabled(selectedCategory == .documents)
                
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }
            } header: {
                Text("Add Photo")
            }

            Button(action: submitReport) {
                Text("Submit Report")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Report Found Item")
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $selectedImage, sourceType: imagePickerSource ?? .photoLibrary)
        }
        .alert(isPresented: $showConfirmation) {
            Alert(title: Text("Success"), message: Text("Item report submitted successfully!"), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $showPermissionAlert) {
            Alert(title: Text("Permission Denied"), message: Text(permissionMessage), dismissButton: .default(Text("OK")))
        }
    }

    func submitReport() {
        let newItem = ItemModel(
            name: itemName,
            description: itemDescription,
            category: selectedCategory,
            location: location,
            timestamp: Date(),
            photo: selectedImage
        )
        itemStore.items.append(newItem)
        showConfirmation = true
        
        // Reset fields
        itemName = ""
        itemDescription = ""
        location = ""
        selectedCategory = .other
        selectedImage = nil
    }

    func presentImageOptions() {
        let alert = UIAlertController(title: "Select Photo", message: "Choose from Camera or Photo Library", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Take a Photo", style: .default, handler: { _ in
            requestCameraPermission()
        }))
        
        alert.addAction(UIAlertAction(title: "Add from Library", style: .default, handler: { _ in
            requestPhotoLibraryPermission()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let controller = windowScene.windows.first?.rootViewController {
            controller.present(alert, animated: true)
        }
    }

    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { response in
            DispatchQueue.main.async {
                if response {
                    print("Camera permission granted")
                    imagePickerSource = .camera
                    // Adding a slight delay to ensure state is updated and view hierarchy is settled
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showingImagePicker = true
                    }
                } else {
                    print("Camera permission denied")
                    permissionMessage = "Camera access is denied. Please enable it in settings."
                    showPermissionAlert = true
                }
            }
        }
    }

    func requestPhotoLibraryPermission() {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                if status == .authorized {
                    print("Photo Library permission granted")
                    imagePickerSource = .photoLibrary
                    showingImagePicker = true
                } else {
                    print("Photo Library permission denied")
                    permissionMessage = "Photo Library access is denied. Please enable it in settings."
                    showPermissionAlert = true
                }
            }
        }
    }
}

struct ReportFoundItemScreen_Previews: PreviewProvider {
    static var previews: some View {
        ReportFoundItemScreen()
            .environmentObject(ItemStore()) // Inject the ItemStore into the preview
    }
}
