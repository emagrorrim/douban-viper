//
//  GalleryInteractor.swift
//  Douban
//
//  Created by Guo Xin on 2/16/17.
//  Copyright © 2017 XinGuo. All rights reserved.
//

import Foundation

class RecommendationInteractorImp: RecommendationInteractor {
  let inThreatersMoviesNetworkService :InThreatersMoviesNetworkService
  
  init(networkService: InThreatersMoviesNetworkService) {
    inThreatersMoviesNetworkService = networkService
  }
  
  func fetchInTheatersMovies(completion: (Dictionary<String, Any>) -> ()) {
    
  }
}
