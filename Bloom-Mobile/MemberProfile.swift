//
//  MemberProfile.swift
//  Bloom-Mobile
//
//  Created by Harry Smallbone on 13/04/2016.
//  Copyright © 2016 Bloom. All rights reserved.
//

import Foundation
class MemberProfile {
    var startupName:String
    var startupDescription:String
    var firstName:String
    var lastName:String
    var userDescription:String
    var interests: [String]
    var skills: [String]
    
    static func loadProfile(user_id:String, callback: (MemberProfile?)->(Void)){
        API.postJSON("http://apply.bloom.org.au/api/profiles/" + user_id, data: NSDictionary(), completionHandler: {(data, response, error) in
            if error != nil {
                print(error)
                callback(nil)
                return
            }
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            if json["error"] != nil {
                print(json["error"])
                callback(nil)
                return
            }
            let profile = MemberProfile()
            profile.userDescription = json["profile"]["description"]
            profile.startupName = json["profile"]["startup_name"]
            profile.startupDescription = json["profile"]["startup_description"]
            profile.firstName = json["firstname"]
            profile.lastName = json["lastname"]
            profile.interests = json["profile"]["interests"]
            profile.skills = json["profile"]["skills"]
            callback(profile)
        })
    }
    
    static func primaryProfile() {
        return primaryProfile
    }
    
    static func setPrimaryProfile(profile:MemberProfile){
        primaryProfile = profile
    }
    
    private static var primaryProfile
}