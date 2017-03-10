//
//  GalleryMovie.swift
//  Douban
//
//  Created by Guo Xin on 02/03/2017.
//  Copyright © 2017 XinGuo. All rights reserved.
//

import Foundation

struct GalleryMovie {
  var title: String
  var rate: Float
  var imageUrl: String
  
  init(with title: String, rate: Float, imageUrl: String) {
    self.title = title
    self.rate = rate
    self.imageUrl = imageUrl
  }
  
  init(with movie: Movie) {
    self.title = movie.title
    self.imageUrl = movie.images.large
    self.rate = (movie.rating?.average ?? 0.0) / (Float(movie.rating?.max ?? 10))
  }
}
