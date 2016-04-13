//
//  ProfileViewController.swift
//  Bloom-Mobile
//
//  Created by Ashwin Daniel D'Cruz on 23/03/2016.
//  Copyright © 2016 Bloom. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var userDescription: UITextField!
    @IBOutlet weak var startupName: UITextField!
    @IBOutlet weak var startupDescription: UITextView!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var interests: UITableView!
    @IBOutlet weak var skills: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}