//
//  MovieSectionCell.swift
//  Douban
//
//  Created by Guo Xin on 28/02/2017.
//  Copyright © 2017 XinGuo. All rights reserved.
//

import UIKit
import RxSwift

class MovieSectionCell: UITableViewCell {
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var movieSectionSelector: MoviesSectionSelectorView!
  
  private let disposeBag = DisposeBag()
  
  var galleryMovies: [GalleryMovie] = []

  override func awakeFromNib() {
    super.awakeFromNib()
    setupCollectionView()
  }
  
  func configureCell(with movies: Variable<[GalleryMovie]>, delegate: MoviesSectionSelectorDelegate?) {
    movies.asObservable().subscribe(onNext: { [weak self] galleryMovies in
      guard let strongSelf = self else {
        return
      }
      strongSelf.galleryMovies = galleryMovies
      strongSelf.collectionView.reloadData()
    }).addDisposableTo(disposeBag)
    movieSectionSelector.configureMovieSelectorDelegate(delegate: delegate)
  }
  
  private func setupCollectionView() {
    collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    collectionView.register(UINib(nibName: "GalleryMovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
  }
}

extension MovieSectionCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return galleryMovies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? GalleryMovieCell else {
      return UICollectionViewCell()
    }
    cell.configure(with: galleryMovies[indexPath.row])
    return cell
  }
}

extension MovieSectionCell: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 110, height: 175)
  }
}

extension MovieSectionCell: UICollectionViewDelegate {
  
}
