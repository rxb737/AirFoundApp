AirFound - Lost & Found System for Airports

Overview

AirFound is a Swift-based iOS app designed to help users report and claim lost items in an airport. The app ensures security with an email verification system before allowing access to item details.
Features

✅ Report Lost Items – Users can submit details about lost items.
✅ Search for Items – Users can look up found items.
✅ Secure Verification – Email-based verification before accessing sensitive information.
✅ Guided Collection – Instructions for retrieving lost items.
Project Structure

📂 Models
ItemModel.swift – Defines the structure of reported items (name, description, category, location, timestamp, airline, flight number, email).
ItemStore.swift – Handles storage and retrieval of reported lost items.
📂 Helpers
VerificationEmail.swift – Handles email verification via SMTP.
📂 Screens
AirportSelectionScreen.swift – Allows users to select an airport before proceeding.
FlightInfoScreen.swift – Users enter flight details and email for verification.
GuidanceScreen.swift – Provides instructions on retrieving the lost item.
HomeScreen.swift – Main screen of the app where users choose actions.
ImagePicker.swift – Allows users to upload images of lost/found items.
ItemDetailsScreen.swift – Displays details of a found item after verification.
ReportFoundItemScreen.swift – Users report a found item with details.
SearchLostItemScreen.swift – Users search for their lost items in the system.
VerificationScreen.swift – Accepts verification code and confirms access to item details.
Setup Instructions

🔧 Requirements
Xcode
Swift 5+
SMTP setup with Gmail (or another provider)
