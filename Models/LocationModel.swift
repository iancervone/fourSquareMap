
import Foundation

struct LocationResults: Codable {
    let response: Response?
}

struct Response: Codable {
    let groups: [Groups]?
}

struct Groups: Codable {
    let items: [Venue]?
}

struct Venue: Codable {
    let venue: VenueDetails?
}

struct VenueDetails: Codable {
    let id: String?
    let name: String?
    let location: Location?
    let distance: Double?
    let neighborhood: String?
    let city: String?
    let state: String?
    let formattedAddress: String?
    let categories: [Categories]?
}

struct Location: Codable {
    let lat: Double?
    let lng: Double?
}

struct Categories: Codable {
    let id: String?
    let name: String?
    let shortName: String?
}
