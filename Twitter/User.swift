//
//  User.swift
//  Twitter
//
//  Created by kate_odnous on 8/15/16.
//  Copyright © 2016 Kate Odnous. All rights reserved.
//

import UIKit

class User: NSObject {
  static let currentUserStorageKey = "currentUserData"
  static let userDidLogoutNotification = "UserDidLogout"

  var name: String?
  var screenName: String?
  var profilePhotoUrl: NSURL?
  var profileBannerUrl : NSURL?
  var tagline: String?
  var dictionary: NSDictionary?

  init(dictionary: NSDictionary) {
    self.dictionary = dictionary

    name = dictionary["name"] as? String
    screenName = dictionary["screen_name"] as? String
    let profileURLString = dictionary["profile_image_url_https"] as? String
    if let profileURLString = profileURLString {
      profilePhotoUrl = NSURL(string: profileURLString)
    }
    if let profileBannerUrl = dictionary["profile_banner_url"] as? String {
      self.profileBannerUrl = NSURL(string: profileBannerUrl)
    }
    tagline = dictionary["description"] as? String
  }


  static var _currentUser: User?

  class var currentUser: User? {
    get {
      if _currentUser == nil {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let userData = userDefaults.objectForKey(User.currentUserStorageKey) as? NSData

        if let userData = userData {
          let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
          _currentUser = User(dictionary: dictionary)
        }
      }
      return _currentUser
    }
    set(user) {
      let userDefaults = NSUserDefaults.standardUserDefaults()
      if let user = user {
        let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
        userDefaults.setObject(data, forKey: User.currentUserStorageKey)
      } else {
        userDefaults.setObject(nil, forKey: User.currentUserStorageKey)
      }

      userDefaults.synchronize()
    }
  }
}