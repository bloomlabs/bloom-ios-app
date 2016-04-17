//
//  BloomTabBarControllerViewController.swift
//  Bloom-Mobile
//
//  Created by Harry Smallbone on 17/04/2016.
//  Copyright © 2016 Bloom. All rights reserved.
//

import UIKit

class BloomTabBarControllerViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
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
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if let profileController = viewController as? ProfileViewController {
            profileController.load(MemberProfile.primaryProfile(), editable: true)
        }
    }
}
