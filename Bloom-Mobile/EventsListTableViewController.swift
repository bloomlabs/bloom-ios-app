//
//  EventsListTableViewController.swift
//  Bloom-Mobile
//
//  Created by Ashwin Daniel D'Cruz on 4/04/2016.
//  Copyright © 2016 Bloom. All rights reserved.
//

import UIKit

class EventsListTableViewController: UITableViewController {
    
    //MARK:Properties
    var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()

       loadSampleEvents()
    }

    func loadSampleEvents(){
        
        let event1 = Event(summary: "First event", eventDescription: "Boring", location: "Nowhere", startTime: "Now", endTime: "Later")
        let event2 = Event(summary: "Second event", eventDescription: "Bleh", location: "Somewhere", startTime: "Later", endTime: "Now")
        
        events += [event1!, event2!] //for some reason we need the exclamation mark. I think it forces an unwrap because Event could be nil
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
        cell.eventDescription.text = event.eventDescription
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
