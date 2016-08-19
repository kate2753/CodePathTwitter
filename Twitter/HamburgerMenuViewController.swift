//
//  HamburgerMenuViewController.swift
//  Twitter
//
//  Created by kate_odnous on 8/19/16.
//  Copyright © 2016 Kate Odnous. All rights reserved.
//

import UIKit

class HamburgerMenuViewController: UIViewController {

  @IBOutlet weak var menuView: UIView!
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!

  var originalLeftMargin: CGFloat!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {
    let translation = sender.translationInView(view)
    let velocity = sender.velocityInView(view)

    if sender.state == .Began {
      originalLeftMargin = leftMarginConstraint.constant
    } else if sender.state == .Changed {
      if (translation.x > 0) {
        leftMarginConstraint.constant = originalLeftMargin + translation.x
      }
    } else if sender.state == .Ended {
      UIView.animateWithDuration(
        0.2,
        delay: 0,
        options: [],
        animations: { [weak self] in
          if let sSelf = self {
            if velocity.x > 0 {
              sSelf.leftMarginConstraint.constant = sSelf.view.frame.size.width - 80
            } else {
              sSelf.leftMarginConstraint.constant = 0
            }
            sSelf.view.layoutIfNeeded()
          }
        },
        completion: nil)
    }
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
