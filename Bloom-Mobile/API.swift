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
    static let base_url:String = "https://bloom-app.herokuapp.com/"
    
    static func setUserToken(token: String, user_id: String) {
        API.token = token
        API.user_id = user_id
    }

    static func postJSON(url: String, data: NSDictionary, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void)->NSURLSessionTask {
        let url = NSURL(string: base_url + url)
        let req = NSMutableURLRequest(URL: url!, cachePolicy: .UseProtocolCachePolicy, timeoutInterval: 60)
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        req.setValue("Token token=" + (Environment.getEnv("BloomAPIKey") as! String), forHTTPHeaderField: "Authorization")
        let postData:NSData = try! NSJSONSerialization.dataWithJSONObject(data, options: [])
        
        req.HTTPBody = postData
        req.HTTPMethod = "POST"
        let task = NSURLSession.sharedSession().dataTaskWithRequest(req, completionHandler: completionHandler)
        task.resume()
        return task
    }
}