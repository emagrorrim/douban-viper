//
//  Copyright © 2017 XinGuo. All rights reserved.
//

import Foundation

protocol InThreatersMoviesNetworkService {
  
  func fetchInThreatersMovies(_ start: Int, count: Int, city: String, completion: () -> ())
}

class InThreatersMoviesNetworkServiceImp: InThreatersMoviesNetworkService {
  private var client: NetworkClient
  
  
  init() {
    client = ClientImp("https://api.douban.com/v2")
  }
  
  func fetchInThreatersMovies(_ start: Int, count: Int, city: String, completion: () -> ()) {
    client.get(urlForInTheatersMovies(), parameters:["city": city, "count": count, "start": start]) { response in
      print(response)
    }
  }
  
  private func urlForInTheatersMovies() -> String {
    return "movie/in_theaters"
  }
}
