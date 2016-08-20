//
//  MenuItem.swift
//  Twitter
//
//  Created by kate_odnous on 8/19/16.
//  Copyright © 2016 Kate Odnous. All rights reserved.
//

import UIKit

class MenuItem: NSObject {
  var title: String
  var image: UIImage

  init(title: String, image: UIImage) {
    self.title = title
    self.image = image
  }
}
