//
//  GalleriesInteractorProtocol.swift
//  Douban
//
//  Created by Guo Xin on 2/16/17.
//  Copyright © 2017 XinGuo. All rights reserved.
//

import Foundation

protocol GalleryInteractor {
  
  func fetchInTheatersMovies(completion: (Dictionary<String, Any>) -> ())
}
