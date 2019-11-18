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

    static func getImages(from data: Data) throws -> [VenuePhoto]? {
        do {
            let result = try JSONDecoder().decode(VenuePhotos.self,from: data)
          return result.response.photos.items
        } catch {
            return nil
        }
    }
}


"https://api.foursquare.com/v2/venues/43695300f964a5208c291fe3/photos?client_id=BKR3JSFXQGW1AJJM3CHLHQOXKNPQF4YE1GSVXBU34QQ1F4D5&client_secret=0VU4B2IKQ2WKSKRWU2TJRH4BGNZUSBOEW2INWELCQNFJISFT&v=20120609"


