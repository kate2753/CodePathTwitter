//
//  User.swift
//  Twitter
//
//  Created by kate_odnous on 8/15/16.
//  Copyright © 2016 Kate Odnous. All rights reserved.
//

import UIKit

class User: NSObject {
  var name: NSString?
  var screenName: NSString?
  var profileUrl: NSURL?
  var tagline: NSString?

  init(dictionary: NSDictionary) {
    name = dictionary["name"] as? NSString
    screenName = dictionary["screen_name"] as? NSString
    let profileURLString = dictionary["profile_image_url_https"] as? String
    if let profileURLString = profileURLString {
      profileUrl = NSURL(string:profileURLString)
    }
    tagline = dictionary["description"] as? NSString
  }
}
