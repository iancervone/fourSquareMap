import Foundation

struct ImageAPIClient {
//    let api_key = Secrets.bestseller_api_key
    
    static let manager = ImageAPIClient()
    
    func getImages(completionHandler: @escaping (Result<[VenuePhoto]?, AppError>) -> Void) {
        
        let urlString = "https://api.foursquare.com/v2/venues/43695300f964a5208c291fe3/photos?client_id=BKR3JSFXQGW1AJJM3CHLHQOXKNPQF4YE1GSVXBU34QQ1F4D5&client_secret=0VU4B2IKQ2WKSKRWU2TJRH4BGNZUSBOEW2INWELCQNFJISFT&v=20120609"
        
        print(urlString)
        guard let url = URL(string: urlString) else {
            fatalError("bad URL")
        }
        
        NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                    
                case let .failure(error):
                    completionHandler(.failure(error))
                    return
                    
                case let .success(data):
                    do {
                        let response = try VenuePhoto.getImages(from: data)
                        completionHandler(.success(response))
                    }
                    catch {
                        completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                    }
                }
            }
        }
    }
    
    private init() {}
}
