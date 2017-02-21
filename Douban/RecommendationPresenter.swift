//
//  Copyright © 2017 XinGuo. All rights reserved.
//

import Foundation
import RxSwift

protocol RecommendationPresentater {
  func allMovies() -> Variable<[Movie]>
  func fetchMovies()
}

class RecommendationPresentaterImp: RecommendationPresentater {
  let recommendationInteractor: RecommendationInteractor? = container.resolve(RecommendationInteractor.self)
  let movies: Variable<[Movie]> = Variable([])
  
  func fetchMovies() {
    recommendationInteractor?.fetchInTheatersMovies() { movies in
      self.movies.value = movies
    }
  }
  
  func allMovies() -> Variable<[Movie]> {
    return movies
  }
}
