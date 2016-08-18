//
//  TweetViewController.swift
//  Twitter
//
//  Created by kate_odnous on 8/17/16.
//  Copyright © 2016 Kate Odnous. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
  @IBOutlet weak var profilePhotoImageView: UIImageView!
  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var userHandle: UILabel!
  @IBOutlet weak var tweetText: UILabel!
  @IBOutlet weak var tweetTime: UILabel!
  @IBOutlet weak var retweetsLabel: UILabel!
  @IBOutlet weak var favoritesLabel: UILabel!


  var tweet: Tweet?

  override func viewDidLoad() {
    super.viewDidLoad()

    if let tweet = tweet {
      profilePhotoImageView.setImageWithURL(tweet.user.profileUrl!)
      userName.text = tweet.user.name
      userHandle.text = tweet.user.screenName
      tweetText.text = tweet.text
      tweetTime.text = tweet.formattedTime
      if tweet.retweetCount > 0 {
        retweetsLabel.text = "\(tweet.retweetCount)"
      }
      if tweet.favoritesCount > 0 {
        favoritesLabel.text = "\(tweet.favoritesCount)"
      }
    }

//    navigationController.
//    view.preservesSuperviewLayoutMargins
//    view.navigation
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */

}
