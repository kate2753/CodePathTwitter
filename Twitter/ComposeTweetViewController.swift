//
//  ComposeTweetViewController.swift
//  Twitter
//
//  Created by kate_odnous on 8/16/16.
//  Copyright © 2016 Kate Odnous. All rights reserved.
//

import UIKit

@objc protocol ComposeTweetViewControllerDelegate {
  func composeTweetViewController(composeTweetViewController: ComposeTweetViewController, didPostTweet: Tweet)
}

class ComposeTweetViewController: UIViewController {

  @IBOutlet weak var currentUserProfilePhoto: UIImageView!
  @IBOutlet weak var tweetText: UITextView!
  @IBOutlet weak var remainingCharactersLabel: UILabel!
  @IBOutlet weak var tweetButton: UIBarButtonItem!

  weak var delegate: ComposeTweetViewControllerDelegate?

  let maxTweetCharacters = 140

  override func viewDidLoad() {
    super.viewDidLoad()
    self.automaticallyAdjustsScrollViewInsets = false

    if let profilePhotoURL = User.currentUser?.profileUrl {
      currentUserProfilePhoto.setImageWithURL(profilePhotoURL)
    }
    tweetText.becomeFirstResponder()
    tweetText.delegate = self
    handleTweetTextChanged()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onCloseButton(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */

  func handleTweetTextChanged() {
    let numCharacters = tweetText.text.characters.count
    let remainingCharacters = maxTweetCharacters - numCharacters
    remainingCharactersLabel.textColor = remainingCharacters < 15 ? UIColor.redColor() : UIColor.lightGrayColor()
    remainingCharactersLabel.text = "\(remainingCharacters)"

    tweetButton.enabled = numCharacters > 0 &&  remainingCharacters >= 0
  }

  @IBAction func onTweetButton(sender: AnyObject) {
    let statusText = tweetText.text
    TwitterClient.sharedInstance.updateStatus(statusText, success: { (tweet: Tweet) in
      self.delegate?.composeTweetViewController(self, didPostTweet: tweet)
      self.dismissViewControllerAnimated(true, completion: nil)
    }) { (error: NSError) in
      print("Failed to post tweet \(error.localizedDescription)")
    }
  }
}

extension ComposeTweetViewController: UITextViewDelegate {
  func textViewDidChange(textView: UITextView) {
    handleTweetTextChanged()
  }
}
