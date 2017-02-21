//
//  ViewController.swift
//  Douban
//
//  Created by Guo Xin on 2/15/17.
//  Copyright © 2017 XinGuo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol RecommendationView {
}

class RecommendationViewController: UIViewController, RecommendationView {
  @IBOutlet weak var textView: UITextView!
  
  let disposeBag = DisposeBag()
  
  var recommendationPresenter: RecommendationPresentater? = container.resolve(RecommendationPresentater.self)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupInThreaterMoviesObserver()
    
    recommendationPresenter?.fetchMovies()
  }
  
  private func setupInThreaterMoviesObserver() {
    guard let recommendationPresenter = recommendationPresenter else {
      return
    }
    
    recommendationPresenter.allMovies().asObservable()
      .map({ $0.description })
      .bindTo(textView.rx.text)
      .disposed(by: disposeBag)
  }
}
