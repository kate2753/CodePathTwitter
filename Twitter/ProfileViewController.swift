//
//  ProfileViewController.swift
//  Twitter
//
//  Created by kate_odnous on 8/19/16.
//  Copyright © 2016 Kate Odnous. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
  @IBOutlet weak var userHeaderView: UserHeaderView!
  @IBOutlet weak var tweetsCountLabel: UILabel!
  @IBOutlet weak var followingCountLabel: UILabel!
  @IBOutlet weak var followersCountLabel: UILabel!

  var user: User? = User.currentUser

  override func viewDidLoad() {
    super.viewDidLoad()
    userHeaderView.user = user
    if let currentUser = user {
      tweetsCountLabel.text = "\(currentUser.statusesCount)"
      followingCountLabel.text = "\(currentUser.followingCount)"
      followersCountLabel.text = "\(currentUser.followersCount)"
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()

//    self.view.alignmentRectInsets()
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
