//
//  Copyright © 2017 XinGuo. All rights reserved.
//

import Foundation
import ObjectMapper

protocol InThreatersMoviesNetworkService {
  
  func fetchInThreatersMovies(in city: String, completion: ((Any?, Error?) -> ())?)
}

class InThreatersMoviesNetworkServiceImp: InThreatersMoviesNetworkService {
  private let client: NetworkClient? = container.resolve(NetworkClient.self, name: "InThreaters")
  private let maxMoviesCount = 6
  
  func fetchInThreatersMovies(in city: String, completion: ((Any?, Error?) -> ())?) {
    client?.get(urlForInTheatersMovies(), parameters:URLParameters(city)) { response, error in
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
