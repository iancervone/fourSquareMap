
import Foundation

import UIKit

class ImageHelper {
    
    
    static let shared = ImageHelper()
    
  
    func getImage(url: URL, completionHandler: @escaping (Result<UIImage, AppError>) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completionHandler(.failure(.badURL))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noDataReceived))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completionHandler(.failure(.notAnImage))
                return
            }
            
            completionHandler(.success(image))
            }.resume()
    }
        
    private init() {}
}
