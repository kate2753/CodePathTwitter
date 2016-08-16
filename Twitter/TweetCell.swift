//
//  TweetCell.swift
//  Twitter
//
//  Created by kate_odnous on 8/15/16.
//  Copyright © 2016 Kate Odnous. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

  var tweet: Tweet? {
    didSet {
      self.tweetTextLabel.text = tweet?.text
    }
  }

  @IBOutlet weak var tweetTextLabel: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

}
