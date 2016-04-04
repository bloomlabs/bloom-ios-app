//
//  BloomLoginViewController.swift
//  Bloom-Mobile
//
//  Created by Harry Smallbone on 30/03/2016.
//  Copyright © 2016 Bloom. All rights reserved.
//

import UIKit

class BloomLoginViewController: UIViewController, GIDSignInUIDelegate {
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Automatically sign in the user.
        GIDSignIn.sharedInstance().signInSilently()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onGoogleLogin(signIn: GIDSignIn!, user: GIDGoogleUser!) {
        let url = NSURL(string: "http://apply.bloom.org.au/api/get_user_information")
        let req = NSMutableURLRequest(URL: url!, cachePolicy: .UseProtocolCachePolicy, timeoutInterval: 60)
        req.HTTPMethod = "POST";
        let data:NSDictionary = ["userID" : user.userID, "access_token" : user.authentication.accessToken, "clientID" : user.authentication.clientID]
        req.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(data, options: [])
        let task = NSURLSession.sharedSession().dataTaskWithRequest(req) {(data, response, error) in
            if error != nil {
                print(error)
                return
            }
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
        }
        
        task.resume()
        
        self.performSegueWithIdentifier("loggedin", sender: self)
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
