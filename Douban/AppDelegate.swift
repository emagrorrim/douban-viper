//
//  AppDelegate.swift
//  Douban
//
//  Created by Guo Xin on 2/15/17.
//  Copyright © 2017 XinGuo. All rights reserved.
//

import UIKit
import Swinject
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    return true
  }
}

let container = Container() { c in
  c.register(NetworkClient.self, name: "InThreaters") { _ in NetworkClientImp("https://api.douban.com/v2") }
  c.register(InThreatersMoviesNetworkService.self) { _ in InThreatersMoviesNetworkServiceImp() }
  c.register(RecommendationInteractor.self) { _ in RecommendationInteractorImp() }
  c.register(RecommendationPresentater.self) { _ in RecommendationPresentaterImp() }
}
