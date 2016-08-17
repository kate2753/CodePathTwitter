//
//  ComposeTweetViewController.swift
//  Twitter
//
//  Created by kate_odnous on 8/16/16.
//  Copyright © 2016 Kate Odnous. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {

  @IBOutlet weak var currentUserProfilePhoto: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()

    if let profilePhotoURL = User.currentUser?.profileUrl {
      currentUserProfilePhoto.setImageWithURL(profilePhotoURL)
    }
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

}
