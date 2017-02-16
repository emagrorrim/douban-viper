//
//  Client.swift
//  Douban
//
//  Created by Guo Xin on 2/16/17.
//  Copyright © 2017 XinGuo. All rights reserved.
//

import Foundation

protocol NetworkClient {
  func get(_ path: String, parameters: Dictionary<String, Any>, completion: @escaping (Any?, Error?) -> ())
}

class ClientImp: NetworkClient {
  private let networkingManager: AFHTTPSessionManager
  
  private let maxMoviesCount = 6
  
  init(_ baseURL: String) {
    guard let baseURL = URL(string: baseURL) else {
      self.networkingManager = AFHTTPSessionManager()
      return
    }
    self.networkingManager = AFHTTPSessionManager(baseURL: baseURL)
  }
  
  func get(_ path: String, parameters: Dictionary<String, Any>, completion: @escaping (Any?, Error?) -> ()) {
    networkingManager.get(path, parameters: URLParameters(parameters), progress: nil, success: { (task, response) in
      completion(response, nil)
    }) { (task, error) in
      completion(nil, error)
    }
  }
  
  private func URLParameters(_ parameters: Dictionary<String, Any>) -> Dictionary<String, Any> {
    var urlParameters = parameters
    urlParameters["start"] = 0
    urlParameters["count"] = maxMoviesCount
    return urlParameters
  }
}
