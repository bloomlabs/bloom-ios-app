//
//  MemberProfile.swift
//  Bloom-Mobile
//
//  Created by Harry Smallbone on 13/04/2016.
//  Copyright © 2016 Bloom. All rights reserved.
//

import Foundation
class MemberProfile {
    var startupName:String = ""
    var startupDescription:String = ""
    var firstName:String = ""
    var lastName:String = ""
    var userDescription:String = ""
    var interests: [String]  = []
    var skills: [String] = []
    
    static func loadProfile(user_id: String, callback: (MemberProfile?)->(Void)){
        API.postJSON("api/profiles/" + user_id, data: NSDictionary(), completionHandler: {(data, response, error) in
            if error != nil {
                print(error)
                callback(nil)
                return
            }
            var json:NSDictionary = ["error":"Parse failed"]
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! NSDictionary
            } catch {
                print(String.init(data: data!, encoding: NSUTF8StringEncoding))
            }
            if json["error"] != nil {
                print(json["error"])
                if json["error"] as! String == "Not Found" {
                    callback(MemberProfile())
                } else {
                    callback(nil)
                }
                return
            } 
            let profile = MemberProfile()
            let profilePart:NSDictionary = json["profile"] as! NSDictionary
            profile.firstName = json["firstname"] as! String
            profile.lastName = json["lastname"] as! String
            profile.userDescription = profilePart["description"] as! String
            profile.startupName = profilePart["startup_name"] as! String
            profile.startupDescription = profilePart["startup_description"] as! String
            profile.interests = profilePart["interests"] as! [String]
            profile.skills = profilePart["skills"] as! [String]
            callback(profile)
        })
    }
    
    static func primaryProfile() -> MemberProfile {
        return primary_profile
    }
    
    static func setPrimaryProfile(profile:MemberProfile){
        primary_profile = profile
    }
    
    private static var primary_profile: MemberProfile = MemberProfile()
}