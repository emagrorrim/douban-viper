//
//  GalleryMovieCell.swift
//  Douban
//
//  Created by Guo Xin on 02/03/2017.
//  Copyright © 2017 XinGuo. All rights reserved.
//

import UIKit
import Cosmos

class GalleryMovieCell: UICollectionViewCell {
  @IBOutlet var heroImage: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var ratingView: CosmosView!
  
  let ratingViewStarColor = UIColor(red: 240.0 / 255.0, green: 192.0 / 255.0, blue: 45 / 255.0, alpha: 1.0)
  
  override func awakeFromNib() {
    super.awakeFromNib()
    contentView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
  }
  
  func configure(with galleryMovie: GalleryMovie) {
    guard let imageUrl = URL(string: galleryMovie.imageUrl) else {
      return
    }
    heroImage.setImageWith(imageUrl)
    nameLabel.text = galleryMovie.title
    configRatingView()
    ratingView.rating = Double(galleryMovie.rate) * Double(ratingView.settings.totalStars)
    ratingView.text = "\(galleryMovie.rate * 10)"
  }
  
  private func configRatingView() {
    var settings = ratingView.settings
    settings.textFont = .systemFont(ofSize: 10)
    settings.emptyBorderColor = ratingViewStarColor
    settings.filledColor = ratingViewStarColor
    settings.emptyColor = .clear
    settings.filledBorderColor = ratingViewStarColor
    settings.fillMode = .half
    settings.starSize = 12.0
    settings.starMargin = 0.0
    ratingView.settings = settings
  }
}
