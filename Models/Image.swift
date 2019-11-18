import Foundation

struct VenuePhotos: Codable {
    let response: Photo?
}

struct Photo: Codable {
    let photos: Item?
}

struct Item: Codable {
    let items: [VenuePhoto]?
}

struct VenuePhoto: Codable {
    let prefix: String?
    let suffix: String?

    static func getImages(from data: Data) throws -> [VenuePhoto]? {
        do {
            let result = try JSONDecoder().decode(VenuePhotos.self,from: data)
          return result.response?.photos?.items
        } catch {
            return nil
        }
    }
}





