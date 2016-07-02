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
    @IBOutlet weak var errorLabel: UILabel!
    
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
        API.postJSON("api/user_auth_token", data: data,  completionHandler: {(data, response, error) in
            if error != nil {
                print(error)
                return
            }
            var json:NSDictionary = ["error": "Parse failed"]
            do{
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
            } catch {
                print(String.init(data: data!, encoding: NSUTF8StringEncoding))
            }
            if json["error"] != nil {
                print("Error fetching user token: " + (json["error"] as! String))
                return
            }
            let token:String = String(json["token"]!)
            let user_id:String = String(json["id"]!)
            API.setUserToken(token, user_id: user_id)
            MemberProfile.loadProfile(user_id, callback: {(profile) in 
                self.activityIndicator.stopAnimating()
                if profile == nil {
                    self.errorLabel.text = "Could not sign you in with Bloom."
                    self.errorLabel.textColor = UIColor.redColor()
                } else {
                    MemberProfile.setPrimaryProfile(profile!)
                    self.performSegueWithIdentifier("loggedin", sender: self)
                }
            })
        })
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
