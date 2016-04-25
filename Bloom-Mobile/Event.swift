//
//  Event.swift
//  Bloom-Mobile
//
//  Created by Ashwin Daniel D'Cruz on 4/04/2016.
//  Copyright © 2016 Bloom. All rights reserved.
//

import UIKit

class Event: NSObject {
    
    //MARK: Properties
    //These are based on some of the fields of an event in terms of Google's resource representation
    var summary: String!
    var eventDescription: String?
    var location: String?
    //var startTime: String?
    //var endTime: String?
    var start:NSDate?
    var end:NSDate?
    
    
    //MARK: Initialization
    
    init?(summary:String!, eventDescription:String?, location:String?, start:NSDate?, end:NSDate?) {
        
        super.init()
        // Initialize stored properties.
        self.summary = summary
        self.eventDescription = eventDescription
        self.location = location
        self.start = start
        self.end = end
        
        
        if(summary.isEmpty){
            return nil
        }
        
    }
    
    
    
    
}
