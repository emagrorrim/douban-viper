//
//  Copyright © 2017 XinGuo. All rights reserved.
//

import Foundation

protocol InThreatersMoviesNetworkService {
  
  func fetchInThreatersMovies(from city: String, completion: (([Movie]) -> ())?)
}

class InThreatersMoviesNetworkServiceImp: InThreatersMoviesNetworkService {
  private var client: NetworkClient
  private let maxMoviesCount = 6
  
  init() {
    client = ClientImp("https://api.douban.com/v2")
  }
  
  func fetchInThreatersMovies(from city: String, completion: (([Movie]) -> ())?) {
    client.get(urlForInTheatersMovies(), parameters:URLParameters(city)) { response, error in
      guard let response = response as? Dictionary<String, Any> else {
        completion?([])
        return
      }
      let subjects = response["subjects"]
      guard let subject = subjects else {
        return
      }
      print(subject)
    }
  }
  
  private func urlForInTheatersMovies() -> String {
    return "movie/in_theaters"
  }
  
  private func URLParameters(_ city: String) -> Dictionary<String, Any> {
    return ["start": 0, "count": maxMoviesCount, "city": city]
  }
}
