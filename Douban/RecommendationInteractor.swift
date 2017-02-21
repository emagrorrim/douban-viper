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
  func fetchInTheatersMovies(completion: @escaping ([Movie]) -> ())
}

class RecommendationInteractorImp: RecommendationInteractor {
  private let inThreatersMoviesNetworkService :InThreatersMoviesNetworkService? = container.resolve(InThreatersMoviesNetworkService.self)
  
  func fetchInTheatersMovies(completion: @escaping ([Movie]) -> ()) {
    inThreatersMoviesNetworkService?.fetchInThreatersMovies(in: city()) { (response, error) in
      guard let response = response as? [String: AnyObject],
        let subjects = response["subjects"] as? [[String: Any]] else {
          completion([])
          return
      }
      let movies = subjects.map({ Movie(JSON: $0) }).flatMap({ $0 })
      completion(movies)
    }
  }

  private func galleryMovies(movies: [Movie]) {
    
  }
  
  private func city() -> String {
    return "西安"
  }
}
