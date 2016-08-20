//
//  MenuCell.swift
//  Twitter
//
//  Created by kate_odnous on 8/19/16.
//  Copyright © 2016 Kate Odnous. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
  @IBOutlet weak var menuTitleLabel: UILabel!
  @IBOutlet weak var menuIconImageView: UIImageView!

  var menuItem: MenuItem! {
    didSet {
      menuTitleLabel.text = menuItem.title
      menuIconImageView.image = menuItem.image
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
