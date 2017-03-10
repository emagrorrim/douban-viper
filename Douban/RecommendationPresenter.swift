//
//  Copyright © 2017 XinGuo. All rights reserved.
//

import Foundation
import RxSwift

protocol RecommendationPresentater: MoviesSectionSelectorDelegate {
  var sections: [String] { get }
  func allMovies() -> Variable<[GalleryMovie]>
}

class RecommendationPresentaterImp: RecommendationPresentater {
  var sections: [String] = ["Movies"]
  let recommendationInteractor: RecommendationInteractor? = container.resolve(RecommendationInteractor.self)
  let movies: Variable<[GalleryMovie]> = Variable([])
  
  init() {
    recommendationInteractor?.fetchInTheatersMovies() { [weak self] movies in
      self?.movies.value = movies
    }
  }
  
  func allMovies() -> Variable<[GalleryMovie]> {
    return movies
  }
}

extension RecommendationPresentaterImp: MoviesSectionSelectorDelegate {
  func didSelectComingSoonMovies() {
    recommendationInteractor?.fetchComingSoonMovies() { [weak self] movies in
      self?.movies.value = movies
    }
  }
  
  func didSelectInThreaterMovies() {
    recommendationInteractor?.fetchInTheatersMovies() { [weak self] movies in
      self?.movies.value = movies
    }
  }
}
