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
        self.activityIndicator.startAnimating()
        let data:NSDictionary = ["id_token" : user.authentication.idToken, "audience": user.authentication.clientID]
        API.postJSON("http://apply.bloom.org.au/api/user_auth_token", data: data,  completionHandler: {(data, response, error) in
            if error != nil {
                print(error)
                return
            }
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            if json["error"] != nil {
                print(json["error"])
                return
            }
            let token:String = json["token"] as! String
            let user_id:String = json["id"] as! String
            API.setUserToken(token, user_id: user_id)
            API.postJSON("http://apply.bloom.org.au/api/profiles/" + user_id, data: NSDictionary(), completionHandler: {(data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
                if json["error"] != nil {
                    print(json["error"])
                    return
                }
                self.activityIndicator.stopAnimating()
            })
        })
        
        
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
