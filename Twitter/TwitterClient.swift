//
//  TwitterClient.swift
//  Twitter
//
//  Created by kate_odnous on 8/15/16.
//  Copyright © 2016 Kate Odnous. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
  static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "qeePgrCtYytrL9Bi3LKF2IoWu", consumerSecret: "CziifpOruZyoXYWwXS4UnW68lbJGvI4f7o82y0xQJsHX6wNrJS")

  var loginSuccess: (() -> ())?
  var loginFailure: ((NSError) -> ())?

  func homeTimeline(success: ([Tweet]) -> Void, failure: (NSError) -> Void) {
    GET("1.1/statuses/home_timeline.json",
        parameters: nil,
        progress: nil,
        success: { (task: NSURLSessionDataTask, response: AnyObject?) in
          let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
          success(tweets)
      },
        failure: { (task: NSURLSessionDataTask?, error: NSError) in
          failure(error)
    })
  }

  func currentAccount(success: (User) -> (), failure: ((NSError) -> ())?) {
    GET("1.1/account/verify_credentials.json",
        parameters: nil,
        progress: nil,
        success: { (task: NSURLSessionDataTask, response: AnyObject?) in
          let userDictionary = response as!  NSDictionary
          let user = User(dictionary: userDictionary)
          success(user)
      },
        failure: { (task: NSURLSessionDataTask?, error: NSError) in
          failure?(error)
    })
  }

  func login(success: () -> (), failure: (NSError) -> ()) {
    loginSuccess = success
    loginFailure = failure

    // make sure previous sessions are cleared
    TwitterClient.sharedInstance.deauthorize()
    TwitterClient.sharedInstance.fetchRequestTokenWithPath(
      "oauth/request_token",
      method: "GET",
      callbackURL: NSURL(string:"twitterassignment://oauth"),
      scope: nil,
      success: { (requestToken: BDBOAuth1Credential!) -> Void in
        let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
        UIApplication.sharedApplication().openURL(url)
      },
      failure: { (error: NSError!) -> Void in
        self.loginFailure?(error)
      }
    )
  }

  func logout() {
    User.currentUser = nil
    deauthorize()

    NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
  }

  func handleOpenUrl(url: NSURL) {
    let requestToken = BDBOAuth1Credential(queryString: url.query)
    fetchAccessTokenWithPath(
      "oauth/access_token",
      method: "POST",
      requestToken: requestToken,
      success: { (credential: BDBOAuth1Credential!) in
        self.currentAccount({
          (user:User) -> () in
          User.currentUser = user
          },
          failure: self.loginFailure)
        self.loginSuccess?()
      },
      failure: { (error: NSError!) in
        self.loginFailure?(error)
      }
    )
    
  }
}
