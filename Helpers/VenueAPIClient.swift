
import Foundation

class VenueAPIClient {
    private init() {}
    static let manager = VenueAPIClient()
    
  func getVenues(near: String, query: String, completionHandler: @escaping (Result<[Venue], AppError>) -> () ){

    let urlString = "https://api.foursquare.com/v2/venues/search?client_id=\(FourSquareLogin.apiClientId)&client_secret=\(FourSquareLogin.apiClientSeceret)&v=20120609&limit=10&near=\(near),IL&query=\(query)"
        
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
