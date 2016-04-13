//
//  Environment.swift
//  Bloom-Mobile
//
//  Created by Harry Smallbone on 13/04/2016.
//  Copyright © 2016 Bloom. All rights reserved.
//

import Foundation
class Environment {
    static var env:NSDictionary = NSDictionary.init(contentsOfFile: NSBundle.mainBundle().pathForResource("Environment", ofType: "plist"))
    static func getEnv(key:String) {
        return env.objectForKey(key)
    }
}