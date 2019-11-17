
import Foundation

struct LocationResultsWrapper: Codable {
    let response: ResponseWrapper?
}

struct ResponseWrapper: Codable {
    let groups: [GroupsWrapper]?
}

struct GroupsWrapper: Codable {
    let items: [Venue]?
}

struct Venue: Codable {
    let venue: VenueDetails?
}

struct VenueDetails: Codable {
    let id: String?
    let name: String?
    let location: LocationWrapper?
    let distance: Double?
    let neighborhood: String?
    let city: String?
    let state: String?
    let formattedAddress: String?
    let categories: [CategoriesWrapper]?
}

struct LocationWrapper: Codable {
    let lat: Double?
    let lng: Double?
}

struct CategoriesWrapper: Codable {
    let id: String?
    let name: String?
    let shortName: String?
}
