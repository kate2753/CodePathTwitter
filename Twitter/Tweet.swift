//
//  Tweet.swift
//  Twitter
//
//  Created by kate_odnous on 8/15/16.
//  Copyright © 2016 Kate Odnous. All rights reserved.
//

import UIKit

class Tweet: NSObject {
  var text: String?
  var timestamp: NSDate?
  var formattedTimestamp: String? {
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
  var user: User

  init(dictionary: NSDictionary) {
    print(dictionary)

    text = dictionary["text"] as? String
    retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
    favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0

    let timestampString = dictionary["created_at"] as? String
    if let timestampString = timestampString {
      let formatter = NSDateFormatter()
      formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
      timestamp = formatter.dateFromString(timestampString)
    }
    user = User(dictionary: dictionary["user"] as! NSDictionary)
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
