//
//  ViewController.swift
//  Douban
//
//  Created by Guo Xin on 2/15/17.
//  Copyright © 2017 XinGuo. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    let aa = InThreatersMoviesNetworkServiceImp()
    aa.fetchInThreatersMovies(from: "西安", completion: nil)
  }

}

