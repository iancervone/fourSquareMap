
import Foundation

class VenueAPIClient {
    private init() {}
    static let manager = VenueAPIClient()
    
    func getVenues(lat: Double, long: Double, query: String, completionHandler: @escaping (Result<[Venue], AppError>) -> () ){

      let urlString = "https://api.foursquare.com/v2/venues/explore?client_id=BKR3JSFXQGW1AJJM3CHLHQOXKNPQF4YE1GSVXBU34QQ1F4D5&client_secret=0VU4B2IKQ2WKSKRWU2TJRH4BGNZUSBOEW2INWELCQNFJISFT&v=20191106&limit=2&ll=\(lat),\(long)&query=\(query)"
        
        guard let url = URL(string: urlString)  else {
            completionHandler(.failure(.badURL))
            return
        }
        
        NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure:
                completionHandler(.failure(.noDataReceived))
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(LocationResults.self, from: data)
                    if let retrievedVenues = decodedData.response?.groups?.first?.items {
                        completionHandler(.success(retrievedVenues))
                    } else {
                        completionHandler(.failure(.invalidJSONResponse))
                    }
                    
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
        
    }
}
