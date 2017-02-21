//
//  Copyright © 2017 XinGuo. All rights reserved.
//

import Foundation
import ObjectMapper

struct Movie: Mappable {
  var id: String = ""
  var year: String = ""
  var title: String = ""
  var originalTitle: String = ""
  
  var genres: Array<String> = []
  var rating: Rating?
  var collectCount: Int = 0
  
  var images: (small: String, medium: String, large: String) = ("", "", "")
  
  var casts: Array<Cast> = []
  var directors: Array<Director> = []
  
  init?(map: Map) {}
  
  mutating func mapping(map: Map) {
    id              <- map["id"]
    year            <- map["year"]
    title           <- map["title"]
    originalTitle   <- map["original_title"]
    genres          <- map["genres"]
    rating          <- map["rating"]
    collectCount    <- map["collect_count"]
    images          <- (map["images"], ImagesTransformer())
    casts           <- map["casts"]
    directors       <- map["directors"]
  }
}

struct Rating: Mappable {
  var max: Int = 0
  var min: Int = 0
  var average: Float = 0
  var stars: String = ""
  
  init?(map: Map) {
  }
  
  mutating func mapping(map: Map) {
    max     <- map["max"]
    min     <- map["min"]
    average <- map["average"]
    stars   <- map["stars"]
  }
}

struct Cast: Mappable {
  var id: String = ""
  var name: String = ""
  var avatars: (small: String, medium: String, large: String) = ("", "", "")
  
  init?(map: Map) {
  }
  
  mutating func mapping(map: Map) {
    id      <- map["id"]
    name    <- map["name"]
    avatars <- (map["avatars"], ImagesTransformer())
  }
}

struct Director: Mappable  {
  var id: String = ""
  var name: String = ""
  var avatars: (small: String, medium: String, large: String) = ("", "", "")
  
  init?(map: Map) {
  }
  
  mutating func mapping(map: Map) {
    id      <- map["id"]
    name    <- map["name"]
    avatars <- (map["avatars"], ImagesTransformer())
  }
}

class ImagesTransformer: TransformType {
  typealias Object = (small: String, medium: String, large: String)
  typealias JSON = Dictionary<String, String>
  
  func transformFromJSON(_ value: Any?) -> Object? {
    guard let dict = value as? Dictionary<String, String> else {
      return nil
    }
    if let small = dict["small"], let medium = dict["medium"], let large = dict["large"] {
      return (small, medium, large)
    }
    return nil
  }
  
  func transformToJSON(_ value: Object?) -> JSON? {
    return nil
  }
}
