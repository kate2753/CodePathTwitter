//
//  TweetCell.swift
//  Twitter
//
//  Created by kate_odnous on 8/15/16.
//  Copyright © 2016 Kate Odnous. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var userProfilePicture: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var userHandleLabel: UILabel!
  @IBOutlet weak var tweetTimestampLabel: UILabel!
  @IBOutlet weak var retweetCounLabel: UILabel!
  @IBOutlet weak var likeCountLabel: UILabel!

  var tweet: Tweet? {
    didSet {
      if let tweet = tweet {
        self.tweetTextLabel.text = tweet.text
        self.tweetTimestampLabel.text = tweet.formattedRelativeTime
        self.userNameLabel.text = tweet.user.name
        if let screenName = tweet.user.screenName {
          self.userHandleLabel.text = "@\(screenName)"
        }
        if let profilePictureUrl = tweet.user.profileUrl {
          self.userProfilePicture.setImageWithURL(profilePictureUrl)
        }
        self.userProfilePicture.layer.cornerRadius = 3
        if tweet.retweetCount > 0 {
          self.retweetCounLabel.text = "\(tweet.retweetCount)"
        }

        if tweet.favoritesCount > 0 {
          self.likeCountLabel.text = "\(tweet.favoritesCount)"
        }
      }
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
  
}
