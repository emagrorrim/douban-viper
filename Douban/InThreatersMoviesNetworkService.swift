//
//  Copyright © 2017 XinGuo. All rights reserved.
//

import Foundation
import ObjectMapper

protocol InThreatersMoviesNetworkService {
  
  func fetchInThreatersMovies(from city: String, completion: ((Any?, Error?) -> ())?)
}

class InThreatersMoviesNetworkServiceImp: InThreatersMoviesNetworkService {
  private var client: NetworkClient
  private let maxMoviesCount = 6
  
  init() {
    client = ClientImp("https://api.douban.com/v2")
  }
  
  func fetchInThreatersMovies(from city: String, completion: ((Any?, Error?) -> ())?) {
    client.get(urlForInTheatersMovies(), parameters:URLParameters(city)) { response, error in
      completion?(response, error)
    }
  }
  
  private func urlForInTheatersMovies() -> String {
    return "movie/in_theaters"
  }
  
  private func URLParameters(_ city: String) -> Dictionary<String, Any> {
    return ["start": 0, "count": maxMoviesCount, "city": city]
  }
}
