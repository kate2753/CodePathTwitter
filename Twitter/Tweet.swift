//
//  Tweet.swift
//  Twitter
//
//  Created by kate_odnous on 8/15/16.
//  Copyright © 2016 Kate Odnous. All rights reserved.
//

import UIKit

class Tweet: NSObject {
  var id: String
  var text: String
  var timestamp: NSDate?
  var formattedTime: String? {
    get {
      if let timestamp = timestamp {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .ShortStyle
        return formatter.stringFromDate(timestamp)
      }
      return nil
    }
  }
  var formattedRelativeTime: String? {
    get {
      if let timestamp = timestamp {
        let formatter = NSDateComponentsFormatter()
        formatter.unitsStyle = NSDateComponentsFormatterUnitsStyle.Abbreviated
        formatter.includesApproximationPhrase = false
        formatter.includesTimeRemainingPhrase = false
        formatter.allowedUnits = [.Second, .Minute, .Hour, .Day]
        formatter.maximumUnitCount = 1
        return formatter.stringFromDate(timestamp, toDate: NSDate())
      }
      return nil
    }
  }
  var retweetCount: Int = 0
  var favoritesCount: Int = 0
  var retweeted: Bool = false
  var favorited: Bool = false
  var user: User
  var retweetStatus: Tweet?

  init(dictionary: NSDictionary) {
//    print(dictionary)
    id = dictionary["id_str"] as! String
    text = dictionary["text"] as! String
    retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
    favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0

    if let favorited = dictionary["favorited"] as? Bool {
      self.favorited = favorited
    }
    if let retweeted = dictionary["retweeted"] as? Bool {
      self.retweeted = retweeted
    }

    let timestampString = dictionary["created_at"] as? String
    if let timestampString = timestampString {
      let formatter = NSDateFormatter()
      formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
      timestamp = formatter.dateFromString(timestampString)
    }
    user = User(dictionary: dictionary["user"] as! NSDictionary)

    if let retweet = dictionary["retweet_status"] as? NSDictionary {
      retweetStatus = Tweet(dictionary: retweet)
    }
  }

  class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
    var tweets = [Tweet]()

    for dictionary in dictionaries {
      let tweet = Tweet(dictionary: dictionary)
      tweets.append(tweet)
    }

    return tweets
  }
}
