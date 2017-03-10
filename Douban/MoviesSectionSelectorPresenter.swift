//
//  Copyright © 2017 XinGuo. All rights reserved.
//

import Foundation
import RxSwift

enum MovieSection {
  case inThreater
  case comingSoon
}

protocol MoviesSectionSelectorDelegate {
  func didSelectInThreaterMovies()
  func didSelectComingSoonMovies()
}

protocol MoviesSectionSelectorPresenter {
  var delegate: MoviesSectionSelectorDelegate? { get set }
  var currentSection: Variable<MovieSection> { get }
  func didTapButton(for section: MovieSection)
}

class MoviesSectionSelectorPresenterImp: MoviesSectionSelectorPresenter {
  var delegate: MoviesSectionSelectorDelegate?
  var currentSection: Variable<MovieSection> = Variable(.inThreater)
  
  func didTapButton(for section: MovieSection) {
    currentSection.value = section
    switch section {
    case .inThreater:
      delegate?.didSelectInThreaterMovies()
    case .comingSoon:
      delegate?.didSelectComingSoonMovies()
    }
  }
}
