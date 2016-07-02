//
//  EventViewController.swift
//  Bloom-Mobile
//
//  Created by Ashwin Daniel D'Cruz on 4/04/2016.
//  Copyright © 2016 Bloom. All rights reserved.
//

import UIKit
import EventKit

class EventViewController: UIViewController, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    
    var event: Event!
    var savedEventId : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let event = event { //We know we will have it but you still need to check because otherwise it doesn't like it
            self.summary.text = event.summary
            self.eventDescription.text = event.eventDescription
            self.location.text = event.location
            
            //TODO: Make the date more human readable
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .MediumStyle //Compiler infers what goes before the dot by checking what the left side requires
            dateFormatter.timeStyle = .ShortStyle
            dateFormatter.timeZone = NSTimeZone.localTimeZone()
            
            self.startTime.text = dateFormatter.stringFromDate(event.start!)
            self.endTime.text = dateFormatter.stringFromDate(event.end!)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Calendar 
    
    // Creates an event in the EKEventStore. The method assumes the eventStore is created and
    // accessible
    func createEvent(eventStore: EKEventStore, title: String, location:String, startDate: NSDate, endDate: NSDate) {
        let event = EKEvent(eventStore: eventStore)
        
        event.title = title
        event.location = location
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        //EKAlarm code
        let eventAlarm = EKAlarm(relativeOffset: -86400)//One day before
        event.addAlarm(eventAlarm)
        
        do {
            try eventStore.saveEvent(event, span: .ThisEvent)
            savedEventId = event.eventIdentifier
        } catch {
            print("Bad things happened")
        }
    }
    
    //TODO: Put a little pop-up to tell the user when the event has been saved
    @IBAction func addEvent(sender: UIButton) {
        let eventStore = EKEventStore()
        
        let title = event.summary
        let location = event.location
        let startDate = event.start
        let endDate = event.end
        
        
        if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
            eventStore.requestAccessToEntityType(.Event, completion: {
                granted, error in
                self.createEvent(eventStore, title: title!, location: location!, startDate: startDate!, endDate: endDate!)
            })
        } else {
            createEvent(eventStore, title: title!, location: location!, startDate: startDate!, endDate: endDate!)
        }
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
