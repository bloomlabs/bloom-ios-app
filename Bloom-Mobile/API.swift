//
//  API.swift
//  Bloom-Mobile
//
//  Created by Harry Smallbone on 5/04/2016.
//  Copyright © 2016 Bloom. All rights reserved.
//

import Foundation
class API {
    static var token:String!
    static var user_id:String!
    
    static func setUserToken(token: String, user_id: String) {
        API.token = token
        API.user_id = user_id
    }
    
    static func postJSON(url: String, data: NSDictionary, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {
        let url = NSURL(string: url)
        let req = NSMutableURLRequest(URL: url!, cachePolicy: .UseProtocolCachePolicy, timeoutInterval: 60)
        req.HTTPMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        req.addValue("application/json", forHTTPHeaderField: "Accept")
        
        req.addValue("Token token=" + (Environment.getEnv("BloomAPIKey") as! String), forHTTPHeaderField: "Authorization")
        req.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(data, options: [])
        let task = NSURLSession.sharedSession().dataTaskWithRequest(req, completionHandler: completionHandler)
        task.resume()
    }
}