//
//  Copyright © 2017 XinGuo. All rights reserved.
//

import Foundation

protocol MovieRepository {
  func save(movies: [Movie])
  func provideAllMovies() -> [Movie]
}

class MovieRepositoryImp: MovieRepository {
  private var movies: [Movie] = []
  
  func save(movies: [Movie]) {
    self.movies = movies
  }
  
  func provideAllMovies() -> [Movie] {
    return movies
  }
}
