//
//  UIViewController+UpdateSubviews.swift
//  Douban
//
//  Created by Guo Xin on 10/03/2017.
//  Copyright © 2017 XinGuo. All rights reserved.
//

import Foundation

protocol UIViewRenderable {
  func render()
}

extension UIView {
  func updateSubviews() {
    for subview in subviews {
      if let subview = subview as? UIViewRenderable {
        subview.render()
      }
    }
  }
}
