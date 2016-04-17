//
//  ProfileViewController.swift
//  Bloom-Mobile
//
//  Created by Ashwin Daniel D'Cruz on 23/03/2016.
//  Copyright © 2016 Bloom. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var userDescription: UITextField!
    @IBOutlet weak var startupName: UITextField!
    @IBOutlet weak var startupDescription: UITextView!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var interests: UITableView!
    @IBOutlet weak var interestsAddButton: UIButton!
    @IBOutlet weak var skills: UITableView!
    @IBOutlet weak var skillsAddButton: UIButton!
    var interestsList:[String] = []
    var skillsList:[String] = []
    
    func load(profile: MemberProfile, editable:Bool) {
        userDescription.text = profile.userDescription
        startupName.text = profile.startupName
        fullName.text = profile.firstName + " " + profile.lastName
        startupDescription.text = profile.startupDescription
        interestsList = profile.interests
        skillsList = profile.skills
        
        userDescription.enabled = editable
        startupName.enabled = editable
        fullName.enabled = editable
        startupDescription.editable = editable
        interestsAddButton.hidden = !editable
        skillsAddButton.hidden = !editable
        
        if (editable) {
            userDescription.text = (userDescription.text)!.isEmpty ? "A short description of you" : userDescription.text
            startupName.text = (startupName.text)!.isEmpty ? "Your Bloom project's name" : startupName.text
            startupDescription.text = (startupDescription.text)!.isEmpty ? "A short description of your project" : startupDescription.text
            fullName.text = (fullName.text)!.isEmpty ? "Your name" : fullName.text
            
            interests.editing = true
            skills.editing = true
        }
        
        interests.reloadData()
        skills.reloadData()
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView.isEqual(interests) ? interestsList.count : skillsList.count
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        var arr:[String] = tableView.isEqual(interests) ? interestsList : skillsList
        if editingStyle == .Delete {
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            arr.removeAtIndex(indexPath.row)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let id = "BloomUserProfile" + (tableView.isEqual(interests) ? "Interests" : "Skills")
        let cell = tableView.dequeueReusableCellWithIdentifier(id, forIndexPath: indexPath) ?? UITableViewCell.init(style: .Default, reuseIdentifier: id)
        cell.textLabel!.text = tableView.isEqual(interests) ? interestsList[indexPath.row] : skillsList[indexPath.row]
        cell.layoutIfNeeded()
        return cell
    }
    
    @IBAction func interestsAdd(sender: UIButton!) {
        interestsList.append("New interest")
        interests.insertRowsAtIndexPaths([NSIndexPath.init(forRow: interestsList.count - 1, inSection: 0)], withRowAnimation: .Automatic)
        interests.setNeedsLayout()
    }
    
    @IBAction func skillsAdd(sender: UIButton!) {
        skillsList.append("New skill")
        skills.insertRowsAtIndexPaths([NSIndexPath.init(forRow: skillsList.count - 1, inSection: 0)], withRowAnimation: .Automatic)
        skills.setNeedsLayout()
        skills.layoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interests.autoresizingMask = .FlexibleHeight
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}