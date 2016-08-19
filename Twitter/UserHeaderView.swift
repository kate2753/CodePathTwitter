//
//  UserHeaderView.swift
//  Twitter
//
//  Created by kate_odnous on 8/19/16.
//  Copyright © 2016 Kate Odnous. All rights reserved.
//

import UIKit
import AFNetworking

class UserHeaderView: UIView {
  @IBOutlet private var contentView: UIView!
  @IBOutlet private weak var coverPhotoImageView: UIImageView!
  @IBOutlet private weak var profilePhotoImageView: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var userHandleLabel: UILabel!


  var user: User? {
    didSet {
      if let user = user {
        userNameLabel.text = user.name
        userHandleLabel.text = "@\(user.screenName!)"
        coverPhotoImageView.setImageWithURL(user.profileBannerUrl!)
        profilePhotoImageView.setImageWithURL(user.profilePhotoUrl!)
      }
    }
  }

  /*
   // Only override drawRect: if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func drawRect(rect: CGRect) {
   // Drawing code
   }
   */

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initSubviews()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    initSubviews()
  }

  func initSubviews() {
    // standard initialization logic
    let nib = UINib(nibName: "UserHeaderView", bundle: nil)
    nib.instantiateWithOwner(self, options: nil)
    contentView.frame = bounds
    addSubview(contentView)
  }
  
}
