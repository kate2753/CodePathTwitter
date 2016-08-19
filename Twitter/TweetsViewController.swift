//
//  TweetsViewController.swift
//  Twitter
//
//  Created by kate_odnous on 8/15/16.
//  Copyright © 2016 Kate Odnous. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController {


  @IBOutlet weak var composeTweetButton: UIImageView!
  @IBOutlet weak var tableView: UITableView!

  var tweets: [Tweet]? {
    didSet {
      tableView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    composeTweetButton.userInteractionEnabled = true
    let composeTweetTap = UITapGestureRecognizer(target: self, action: #selector(TweetsViewController.composeTweetTapped))
    composeTweetButton.addGestureRecognizer(composeTweetTap)

    tableView.delegate = self
    tableView.dataSource = self
    tableView.estimatedRowHeight = 200
    tableView.rowHeight = UITableViewAutomaticDimension

    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(TweetsViewController.updateTweets), forControlEvents: UIControlEvents.ValueChanged)
    tableView.insertSubview(refreshControl, atIndex: 0)

    updateTweets(refreshControl)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onLogoutButton(sender: AnyObject) {
    TwitterClient.sharedInstance.logout()
  }

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */

  func updateTweets(refreshControl: UIRefreshControl) {
    TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
      self.tweets = tweets
      refreshControl.endRefreshing()
    }) { (error: NSError) in
      self.tweets = nil
      refreshControl.endRefreshing()
    }
  }

  // MARK: - Gesture recognizer handlers

  func composeTweetTapped(gestureRecognizer: UITapGestureRecognizer) {
    composeTweet(nil)
  }

  func tweetTapped(gestureRecognizer: UITapGestureRecognizer) {
    if let tweetCell = gestureRecognizer.view as? TweetCell {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let tweetViewController = storyboard.instantiateViewControllerWithIdentifier("TweetViewController") as! TweetViewController
      tweetViewController.tweet = tweetCell.tweet
      navigationController?.pushViewController(tweetViewController, animated: true)
    }
  }

  func composeTweet(repyToTweet: Tweet?) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let composeTweetNavigationController = storyboard.instantiateViewControllerWithIdentifier("ComposeTweetNavigationController") as! UINavigationController
    if let composeTweetVc = composeTweetNavigationController.topViewController as? ComposeTweetViewController {
      composeTweetVc.delegate = self
      composeTweetVc.replyToTweet = repyToTweet
    }
    presentViewController(composeTweetNavigationController, animated: true, completion: nil)
  }
}


extension TweetsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets?.count ?? 0
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as! TweetCell
    let tweetTap = UITapGestureRecognizer(target: self, action: #selector(TweetsViewController.tweetTapped))
    cell.addGestureRecognizer(tweetTap)
    cell.tweet = tweets?[indexPath.row]
    cell.delegate = self
    return cell
  }
}

extension TweetsViewController: ComposeTweetViewControllerDelegate {
  func composeTweetViewController(composeTweetViewController: ComposeTweetViewController, didPostTweet tweet: Tweet) {
    tweets?.insert(tweet, atIndex: 0)
    tableView.reloadData()
  }
}

extension TweetsViewController: TweetCellDelegate {
  func tweetCell(tweetCell: TweetCell, didTapReply replyToTweet: Tweet) {
    composeTweet(replyToTweet)
  }

  func tweetCell(tweetCell: TweetCell, didTapUserProfilePhoto user: User) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let userProfileViewController = storyboard.instantiateViewControllerWithIdentifier("UserProfileViewController") as! ProfileViewController
    userProfileViewController.user = user
    userProfileViewController.edgesForExtendedLayout = .None
    navigationController?.pushViewController(userProfileViewController, animated: true)
  }
}
