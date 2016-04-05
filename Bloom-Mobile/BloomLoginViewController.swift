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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        let url = NSURL(string: "http://apply.bloom.org.au/api/user_auth_token")
        let req = NSMutableURLRequest(URL: url!, cachePolicy: .UseProtocolCachePolicy, timeoutInterval: 60)
        req.HTTPMethod = "POST"
        let data:NSDictionary = ["id_token" : user.authentication.idToken, "audience": user.authentication.clientID]
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        req.addValue("Token token=93b36e75142e9eb0d33ed9ef5b6f19da59482bf82d646e451cf5dc27f9c1d14b91ce8043369ebe925ca9177c32624c1452eb9e291610a59b1b6bb66d2d433bce", forHTTPHeaderField: "Authorization")
        req.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(data, options: [])
        let task = NSURLSession.sharedSession().dataTaskWithRequest(req) {(data, response, error) in
            if error != nil {
                print(error)
                return
            }
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            if (json["error"] != nil) {
                print(json["error"])
                return
            }
            let token = json["token"]
            self.activityIndicator.stopAnimating()
        }
        
        self.activityIndicator.startAnimating()
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
