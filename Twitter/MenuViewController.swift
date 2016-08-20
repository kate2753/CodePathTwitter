//
//  MenuViewController.swift
//  Twitter
//
//  Created by kate_odnous on 8/19/16.
//  Copyright © 2016 Kate Odnous. All rights reserved.
//

import UIKit

@objc protocol MenuViewControllerDelegate {
  func menuViewController(menuViewController: MenuViewController, didSelectMenuItem: UIViewController)
}

class MenuViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!

  weak var delegate: MenuViewControllerDelegate?
  var viewControllers = [UIViewController]()
  var menuItems = [MenuItem]()

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    // Do any additional setup after loading the view.
    let homeFeedVC = storyboard.instantiateViewControllerWithIdentifier("TweetsNavigationController")
    let profileVC = storyboard.instantiateViewControllerWithIdentifier("ProvileNavigationController")

    viewControllers.append(homeFeedVC)
    viewControllers.append(profileVC)

    menuItems.append(MenuItem(title: "Home", image: UIImage(named: "feed")!))
    menuItems.append(MenuItem(title: "Profile", image: UIImage(named: "profile")!))

    tableView.reloadData()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
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

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewControllers.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as! MenuCell
    cell.menuItem = menuItems[indexPath.row]
    return cell
  }

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: false)
    delegate?.menuViewController(self, didSelectMenuItem: viewControllers[indexPath.row])
  }
}
