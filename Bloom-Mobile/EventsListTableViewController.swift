//
//  EventsListTableViewController.swift
//  Bloom-Mobile
//
//  Created by Ashwin Daniel D'Cruz on 4/04/2016.
//  Copyright © 2016 Bloom. All rights reserved.
//

import UIKit

class EventsListTableViewController: UITableViewController {
    @IBOutlet weak var table: UITableView!
    //MARK:Properties
    var events = [Event]()
    //var itemsList = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        
        //Make the Get Request
        //iOS key: AIzaSyAAYFnjURSYHRd-s6poOOcHythjM6PcuBc
        //Browser key: AIzaSyA5Kjx_Xh94WsAAOoNBpSU234LhPc4_8cI
        
        let url = NSURL(string: "https://www.googleapis.com/calendar/v3/calendars/bloom.org.au_qfi4gfo8ocv0fof2lr8j0nr25c@group.calendar.google.com/events?key=AIzaSyA5Kjx_Xh94WsAAOoNBpSU234LhPc4_8cI")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in //begin closure?
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                if let resources = json["items"] as? [[String: AnyObject]] { //I think json["items"] is an array of dictionaries where all keys are Strings and their corresponding values can be any type of Object
                    
                    self.loadActualEvents(resources)
                    
                    
                }
                
            } catch {
                print("error serializing JSON: \(error)")
                //completionHandler()
                
            }
        }
        task.resume() //This runs async and the JSON closure above doesn't take effect until this has finished
        
        
        super.viewDidLoad()
    }
    
    //MARK: Load Events helper functions
    
    /*
    func loadSampleEvents(){
        
        let event1 = Event(summary: "First event", eventDescription: "Boring", location: "Nowhere", startTime: "Now", endTime: "Later")
        let event2 = Event(summary: "Second event", eventDescription: "Bleh", location: "Somewhere", startTime: "Later", endTime: "Now")
        
        events += [event1!, event2!] //for some reason we need the exclamation mark. I think it forces an unwrap because Event could be nil
        
        super.viewDidLoad()
    }*/
    

    
    func loadActualEvents(itemList:[[String:AnyObject]]){
        //print("here")
        for event in itemList {
            
            //Get the dates out of the strings
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            dateFormatter.timeZone = NSTimeZone.localTimeZone()
            
            let startString = event["start"]!["dateTime"]! as! String
            let startDate = dateFormatter.dateFromString(startString)
          
            if startDate!.timeIntervalSinceNow.isSignMinus {
                //myDate is earlier than Now (date and time)
                
                
                
            } else {
                //myDate is equal or after than Now (date and time)
                //Get summary, description and location
                let summary = event["summary"] as! String
                
                var description = ""//event["description"] as! String
                if let existingDescription = event["description"]
                {
                    description = existingDescription as! String
                }
                
                var location = ""
                if let existingLocation = event["location"]
                {
                    location = existingLocation as! String
                }
                
                let endString = event["end"]!["dateTime"]! as! String
                let endDate = dateFormatter.dateFromString(endString)
                
                let newEvent = Event(summary: summary, eventDescription: description, location: location, start: startDate, end: endDate)
                events.append(newEvent!)
            }
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
        
        
        //super.viewDidLoad()
        
        /*let event1 = Event(summary: "First event", eventDescription: "Boring", location: "Nowhere", startTime: "Now", endTime: "Later")
        let event2 = Event(summary: "Second event", eventDescription: "Bleh", location: "Somewhere", startTime: "Later", endTime: "Now")
        
        events += [event1!, event2!] //for some reason we need the exclamation mark. I think it forces an unwrap because Event could be nil*/
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return events.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "EventCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as!EventTableViewCell
        
        // Fetches the appropriate event for the data source layout.
        let event = events[indexPath.row]
        cell.summary.text = event.summary
        //cell.eventDescription.text = event.eventDescription
        cell.location.text = event.location
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowDetail" {
            let eventDetailViewController = segue.destinationViewController as! EventViewController //using a '!' means if the cast is unsuccessful, the app will crash
            
            // Get the cell that generated this segue.
            if let selectedEventCell = sender as? EventTableViewCell {
                
                let indexPath = tableView.indexPathForCell(selectedEventCell)!
                let selectedEvent = events[indexPath.row]
                eventDetailViewController.event = selectedEvent
            }
        }
        
    }
    
    
}
