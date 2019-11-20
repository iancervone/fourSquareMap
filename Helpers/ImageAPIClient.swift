import Foundation

struct ImageAPIClient {
//    let api_key = Secrets.bestseller_api_key
    
    static let manager = ImageAPIClient()
    
    func getImages(completionHandler: @escaping (Result<[VenuePhoto]?, AppError>) -> Void) {
        
      let urlString = "https://api.foursquare.com/v2/venues/43695300f964a5208c291fe3/photos?client_id=\(FourSquareLogin.apiClientId)&client_secret=\(FourSquareLogin.apiClientSeceret)&v=20120609"
        
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
                      self.getImages { (result) in
                      }
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
