import Foundation
import UIKit

enum ItemCategory: String, CaseIterable, Identifiable {
    case clothing = "Clothing"
    case electronics = "Electronics"
    case phonesTablets = "Phones & Tablets"
    case documents = "Documents/Passport"
    case jewelry = "Jewelry & Accessories"
    case keysWallets = "Keys & Wallets"
    case earphonesHeadphones = "Earphones & Headphones"
    case medical = "Medical Equipment"
    case books = "Books"
    case foodBeverage = "Food & Beverage"
    case other = "Other"
    
    var id: String { rawValue }
}

enum Airline: String, CaseIterable, Identifiable {
    case aegeanAirlines = "Aegean Airlines"
    case aerLingus = "Aer Lingus"
    case aeroflot = "Aeroflot"
    case airAlsie = "Air Alsie"
    case airBaltic = "Air Baltic"
    case airCanada = "Air Canada"
    case airChina = "Air China"
    case airFrance = "Air France"
    case airGreenland = "Air Greenland"
    case airIndia = "Air India"
    case airSerbia = "Air Serbia"
    case aisAirlines = "AIS Airlines"
    case americanAirlines = "American Airlines"
    case atlanticAirways = "Atlantic Airways"
    case austrianAirlines = "Austrian Airlines"
    case britishAirways = "British Airways"
    case brusselsAirlines = "Brussels Airlines"
    case croatiaAirlines = "Croatia Airlines"
    case danishAirTransport = "Danish Air Transport"
    case deltaAirLines = "Delta Air Lines"
    case easyJet = "easyJet"
    case egyptAir = "EgyptAir"
    case emirates = "Emirates"
    case ethiopianAirlines = "Ethiopian Airlines"
    case etihadAirways = "Etihad Airways"
    case eurowings = "Eurowings"
    case finnair = "Finnair"
    case flyOne = "Fly One"
    case iberia = "Iberia"
    case icelandair = "Icelandair"
    case jet2 = "Jet2.com"
    case klm = "KLM Royal Dutch Airlines"
    case lotPolishAirlines = "LOT Polish Airlines"
    case lufthansa = "Lufthansa"
    case luxair = "Luxair"
    case middleEastAirlines = "Middle East Airlines"
    case norwegian = "Norwegian Air Shuttle"
    case pegasus = "Pegasus Airlines"
    case qatarAirways = "Qatar Airways"
    case ryanair = "Ryanair"
    case sas = "Scandinavian Airlines (SAS)"
    case singaporeAirlines = "Singapore Airlines"
    case sunExpress = "SunExpress"
    case swiss = "Swiss International Air Lines"
    case tap = "TAP Air Portugal"
    case thaiAirways = "Thai Airways"
    case transavia = "Transavia"
    case turkishAirlines = "Turkish Airlines"
    case volotea = "Volotea"
    case vueling = "Vueling Airlines"
    case wideroe = "Widerøe"
    case wizzAir = "Wizz Air"
    case wizzAirMalta = "Wizz Air Malta"
    case other = "Other"

    var id: String { rawValue }
}

struct ItemModel: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var description: String
    var category: ItemCategory
    var location: String
    var timestamp: Date
    var photo: UIImage?
    var airline: Airline? // Airline as an enum
    var flightNumber: String?
    var email: String?

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(flightNumber)
    }

    static func == (lhs: ItemModel, rhs: ItemModel) -> Bool {
        return lhs.id == rhs.id
    }
}
