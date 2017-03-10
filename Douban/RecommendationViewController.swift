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
  @IBOutlet var tableView: UITableView!
  
  let disposeBag = DisposeBag()
  let presenter: RecommendationPresentater? = container.resolve(RecommendationPresentater.self)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
  }
  
  private func setupTableView() {
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    tableView.register(UINib(nibName: "MovieSectionCell", bundle: nil), forCellReuseIdentifier: "MovieGalleryCell")
  }
}

extension RecommendationViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.sections.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieGalleryCell", for: indexPath) as? MovieSectionCell,
      let presenter = presenter else {
      return UITableViewCell()
    }
    cell.configureCell(with: presenter.allMovies(), delegate: presenter)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 175 + 60
  }
}

extension RecommendationViewController: UITableViewDelegate {
  
}
