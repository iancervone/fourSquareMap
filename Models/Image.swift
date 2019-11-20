import Foundation

struct VenuePhotos: Codable {
    let response: Photo
}

struct Photo: Codable {
    let photos: Item
}

struct Item: Codable {
    let items: [VenuePhoto]
}

struct VenuePhoto: Codable {
    let prefix: String
    let suffix: String

    static func getImages(from data: Data) throws -> (String, String) {
            let result = try JSONDecoder().decode(VenuePhotos.self,from: data)
      if result.response.photos.items.count == 0 {
        throw fatalError()
        }
      return (result.response.photos.items[0].prefix, result.response.photos.items[0].suffix)

    }
}





