//
//  MoviesSectionHeader.swift
//  Douban
//
//  Created by Guo Xin on 24/02/2017.
//  Copyright © 2017 XinGuo. All rights reserved.
//

import UIKit
import RxSwift

class MoviesSectionSelectorView: UIView {
  var presenter = container.resolve(MoviesSectionSelectorPresenter.self)
  let disposeBag = DisposeBag()
  
  private let emphasisView = UIView()
  private let inThreaterButton = UIButton()
  private let comingSoonButton = UIButton()
  private let underlineView = UIView()
  private var underlineCenterXConstraint: NSLayoutConstraint?
  
  private let animationDuration = 0.35
  private let verticalMargin: CGFloat = 10.0
  private let horizentalMargin: CGFloat = 5.0
  private let fontSize: CGFloat = 15.0
  private let buttonSize = CGSize(width: 100, height: 25)
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    commonInit()
  }
  
  init() {
    super.init(frame: .zero)
    commonInit()
  }
  
  private func commonInit() {
    setupEmphasisView()
    setupInThreaterButton()
    setupComingSoonButton()
    setupUnderlineView()
    setupSectionSubscribe()
  }
  
  func configureMovieSelectorDelegate(delegate: MoviesSectionSelectorDelegate?) {
    presenter?.delegate = delegate
  }
  
  private func resetMovieSection(by section: MovieSection) {
    guard let underlineCenterXConstraint = underlineCenterXConstraint else {
      return
    }
    removeConstraint(underlineCenterXConstraint)
    UIView.animate(withDuration: animationDuration) {
      switch section {
      case .inThreater:
        self.underlineCenterXConstraint = self.underlineView.centerXAnchor.constraint(equalTo: self.inThreaterButton.centerXAnchor)
      case .comingSoon:
        self.underlineCenterXConstraint = self.underlineView.centerXAnchor.constraint(equalTo: self.comingSoonButton.centerXAnchor)
      }
      self.underlineCenterXConstraint?.isActive = true
      self.layoutIfNeeded()
    }
  }
  
  func tapSectionButtons(sender: UIButton) {
    let section: MovieSection = (sender == inThreaterButton) ? .inThreater : .comingSoon
    presenter?.didTapButton(for: section)
  }
  
  private func setupEmphasisView() {
    let emphasisViewSize = CGSize(width: 3.0, height: 13.0)
    
    addSubview(emphasisView)
    
    emphasisView.backgroundColor = .orange
    emphasisView.layer.cornerRadius = 1.5
    
    emphasisView.translatesAutoresizingMaskIntoConstraints = false
    emphasisView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    emphasisView.heightAnchor.constraint(equalToConstant: emphasisViewSize.height).isActive = true
    emphasisView.widthAnchor.constraint(equalToConstant: emphasisViewSize.width).isActive = true
    emphasisView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
  }
  
  private func setupInThreaterButton() {
    addSubview(inThreaterButton)
    
    inThreaterButton.setTitleColor(.black, for: .normal)
    inThreaterButton.setTitle("热映电影", for: .normal)
    inThreaterButton.titleLabel?.font = .systemFont(ofSize: fontSize)
    inThreaterButton.addTarget(self, action: #selector(tapSectionButtons), for: .touchUpInside)
    let size = inThreaterButton.titleLabel?.intrinsicContentSize ?? buttonSize
    
    inThreaterButton.translatesAutoresizingMaskIntoConstraints = false
    inThreaterButton.leadingAnchor.constraint(equalTo: emphasisView.trailingAnchor, constant: verticalMargin).isActive = true
    inThreaterButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    inThreaterButton.heightAnchor.constraint(equalToConstant: size.height).isActive = true
    inThreaterButton.widthAnchor.constraint(equalToConstant: size.width).isActive = true
  }
  
  private func setupComingSoonButton() {
    addSubview(comingSoonButton)
    
    comingSoonButton.setTitleColor(.black, for: .normal)
    comingSoonButton.setTitle("即将上映", for: .normal)
    comingSoonButton.titleLabel?.font = .systemFont(ofSize: fontSize)
    comingSoonButton.addTarget(self, action: #selector(tapSectionButtons), for: .touchUpInside)
    let size = comingSoonButton.titleLabel?.intrinsicContentSize ?? buttonSize
    
    comingSoonButton.translatesAutoresizingMaskIntoConstraints = false
    comingSoonButton.leadingAnchor.constraint(equalTo: inThreaterButton.trailingAnchor, constant: verticalMargin).isActive = true
    comingSoonButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    comingSoonButton.heightAnchor.constraint(equalToConstant: size.height).isActive = true
    comingSoonButton.widthAnchor.constraint(equalToConstant: size.width).isActive = true
  }
  
  private func setupUnderlineView() {
    let underlineSize = CGSize(width: 45.0, height: 1.0)
    
    addSubview(underlineView);
    
    underlineView.backgroundColor = .orange
    
    underlineView.translatesAutoresizingMaskIntoConstraints = false
    underlineView.widthAnchor.constraint(equalToConstant: underlineSize.width).isActive = true
    underlineView.heightAnchor.constraint(equalToConstant: underlineSize.height).isActive = true
    underlineView.bottomAnchor.constraint(equalTo: inThreaterButton.bottomAnchor, constant: horizentalMargin).isActive = true
    underlineCenterXConstraint = underlineView.centerXAnchor.constraint(equalTo: inThreaterButton.centerXAnchor)
    underlineCenterXConstraint?.isActive = true
  }
  
  private func setupSectionSubscribe() {
    guard let presenter = presenter else {
      return
    }
    presenter.currentSection
      .asObservable()
      .subscribe(onNext: { section in
        self.resetMovieSection(by: section)
      }).addDisposableTo(disposeBag)
  }
}
