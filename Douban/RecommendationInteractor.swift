//
//  GalleryInteractor.swift
//  Douban
//
//  Created by Guo Xin on 2/16/17.
//  Copyright © 2017 XinGuo. All rights reserved.
//

import Foundation
import ObjectMapper

protocol RecommendationInteractor {
  func fetchInTheatersMovies(completion: @escaping ([GalleryMovie]) -> ())
  func fetchComingSoonMovies(completion: @escaping ([GalleryMovie]) -> ())
}

class RecommendationInteractorImp: RecommendationInteractor {
  private let moviesNetworkService :MoviesNetworkService? = container.resolve(MoviesNetworkService.self)
  
  func fetchInTheatersMovies(completion: @escaping ([GalleryMovie]) -> ()) {
    moviesNetworkService?.fetchInThreatersMovies(in: city()) { [weak self] (response, error) in
      guard let response = response as? [String: AnyObject],
        let strongSelf = self,
        let subjects = response["subjects"] as? [[String: Any]] else {
          completion([])
          return
      }
      let movies = subjects.map({ Movie(JSON: $0) }).flatMap({ $0 })
      completion(strongSelf.galleryMovies(movies: movies))
    }
  }
  
  func fetchComingSoonMovies(completion: @escaping ([GalleryMovie]) -> ()) {
    moviesNetworkService?.fetchComingSoonMovies(in: city()) { [weak self] (response, error) in
      guard let response = response as? [String: AnyObject],
        let strongSelf = self,
        let subjects = response["subjects"] as? [[String: Any]] else {
          completion([])
          return
      }
      let movies = subjects.map({ Movie(JSON: $0) }).flatMap({ $0 })
      completion(strongSelf.galleryMovies(movies: movies))
    }
  }

  private func galleryMovies(movies: [Movie]) -> [GalleryMovie] {
    return movies.map() { movie in
      return GalleryMovie.init(with: movie)
    }
  }
  
  private func city() -> String {
    let citys = ["北京", "西安", "上海"]
    let index = Int(arc4random_uniform(3))
    print(citys[index])
    return citys[index]
  }
}
