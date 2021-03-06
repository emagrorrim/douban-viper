//
//  Copyright © 2017 XinGuo. All rights reserved.
//

import Foundation
import ObjectMapper

protocol MoviesNetworkService {
  func fetchInThreatersMovies(in city: String, completion: ((Any?, Error?) -> ())?)
  func fetchComingSoonMovies(in city: String, completion: ((Any?, Error?) -> ())?)
}

class MoviesNetworkServiceImp: MoviesNetworkService {
  private let client: NetworkClient? = container.resolve(NetworkClient.self, name: "InThreaters")
  private let maxMoviesCount = 6
  
  func fetchInThreatersMovies(in city: String, completion: ((Any?, Error?) -> ())?) {
    client?.get(urlForInTheatersMovies, parameters:URLParameters(city)) { response, error in
      completion?(response, error)
    }
  }
  
  func fetchComingSoonMovies(in city: String, completion: ((Any?, Error?) -> ())?) {
    client?.get(urlForComingSoonMovies, parameters:URLParameters(city)) { response, error in
      completion?(response, error)
    }
  }
  
  private var urlForInTheatersMovies: String {
    return "movie/in_theaters"
  }
  
  private var urlForComingSoonMovies: String {
    return "movie/coming_soon"
  }
  
  private func URLParameters(_ city: String) -> Dictionary<String, Any> {
    return ["start": 0, "count": maxMoviesCount, "city": city]
  }
}
