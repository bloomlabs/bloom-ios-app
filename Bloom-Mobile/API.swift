//
//  API.swift
//  Bloom-Mobile
//
//  Created by Harry Smallbone on 5/04/2016.
//  Copyright © 2016 Bloom. All rights reserved.
//

import Foundation
class API {
static func postJSON(url: String, data: NSDictionary, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) {
    let url = NSURL(string: url)
    let req = NSMutableURLRequest(URL: url!, cachePolicy: .UseProtocolCachePolicy, timeoutInterval: 60)
    req.HTTPMethod = "POST"
    req.addValue("application/json", forHTTPHeaderField: "Content-Type")
    req.addValue("application/json", forHTTPHeaderField: "Accept")
    req.addValue("Token token=93b36e75142e9eb0d33ed9ef5b6f19da59482bf82d646e451cf5dc27f9c1d14b91ce8043369ebe925ca9177c32624c1452eb9e291610a59b1b6bb66d2d433bce", forHTTPHeaderField: "Authorization")
    req.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(data, options: [])
    let task = NSURLSession.sharedSession().dataTaskWithRequest(req, completionHandler: completionHandler)
    task.resume()
}
}