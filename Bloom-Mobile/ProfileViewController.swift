//
//  ProfileViewController.swift
//  Bloom-Mobile
//
//  Created by Ashwin Daniel D'Cruz on 23/03/2016.
//  Copyright © 2016 Bloom. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var userDescription: UITextField!
    @IBOutlet weak var startupName: UITextField!
    @IBOutlet weak var startupDescription: UITextView!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var interests: UITableView!
    @IBOutlet weak var interestsAddButton: UIButton!
    @IBOutlet weak var skills: UITableView!
    @IBOutlet weak var skillsAddButton: UIButton!
    var profile:MemberProfile?
    var interestsList:[String] = []
    var skillsList:[String] = []
    
    func load(profile: MemberProfile, editable:Bool) {
        userDescription.text = profile.userDescription
        startupName.text = profile.startupName
        fullName.text = profile.firstName + " " + profile.lastName
        startupDescription.text = profile.startupDescription
        interestsList = profile.interests
        skillsList = profile.skills
        
        self.profile = profile
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView.isEqual(interests) ? interestsList.count : skillsList.count
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            tableView.isEqual(interests) ? interestsList.removeAtIndex(indexPath.row) : skillsList.removeAtIndex(indexPath.row)
            tableView.reloadData()
            profileChanged(tableView)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            if let superview = touch.view {
                for subview in superview.subviews {
                    if ((subview as? EditableTableTextField) != nil) {
                        subview.becomeFirstResponder()
                    }
                }
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let id = "BloomUserProfile" + (tableView.isEqual(interests) ? "Interests" : "Skills")
        let cell = tableView.dequeueReusableCellWithIdentifier(id, forIndexPath: indexPath) ?? UITableViewCell.init(style: .Default, reuseIdentifier: id)
        for subview in cell.subviews {
            if ((subview as? EditableTableTextField) != nil) {
                let textField = subview as! EditableTableTextField
                textField.index = indexPath.row
                textField.sourceArray = tableView.isEqual(interests) ? "i" : "s"
                textField.text = tableView.isEqual(interests) ? interestsList[indexPath.row] : skillsList[indexPath.row]
            }
        }
        return cell
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        if let editTextField = textField as? EditableTableTextField {
            if (editTextField.sourceArray == "i") {
                self.interestsList[editTextField.index] = textField.text!
            } else {
                self.skillsList[editTextField.index] = textField.text!
            }
        }
        profileChanged(textField)
    }
    
    @IBAction func profileChanged(sender: AnyObject) {
        if fullName.text!.isEmpty {
            return
        }
        profile!.userDescription = userDescription.text ?? ""
        profile!.startupName = startupName.text ?? ""
        let parts = fullName.text!.characters.split(2, allowEmptySlices: false, isSeparator: {$0 == " "}).map(String.init)
        profile!.firstName = parts[0]
        profile!.lastName = parts[1]
        profile!.startupDescription = startupDescription.text
        profile!.interests = interestsList
        profile!.skills = skillsList
        profile!.update()
    }
    
    @IBAction func interestsAdd(sender: UIButton!) {
        interestsList.append("New interest")
        interests.insertRowsAtIndexPaths([NSIndexPath.init(forRow: interestsList.count - 1, inSection: 0)], withRowAnimation: .Automatic)
        interests.setNeedsLayout()
        skills.setNeedsLayout()
        profileChanged(sender)
    }
    
    @IBAction func skillsAdd(sender: UIButton!) {
        skillsList.append("New skill")
        skills.insertRowsAtIndexPaths([NSIndexPath.init(forRow: skillsList.count - 1, inSection: 0)], withRowAnimation: .Automatic)
        skills.setNeedsLayout()
        interests.setNeedsLayout()
        profileChanged(sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}