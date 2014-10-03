//
//  ViewController.swift
//  QuotesApp
//
//  Created by Alex Zimin on 02/10/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

import UIKit

var containerName = "group.alex.quotes"

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func saveAction(sender: UIButton) {
        self.textFieldShouldReturn(textField)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let userDefaults = NSUserDefaults(suiteName: containerName) // User Defaults container
        userDefaults.setObject(textField.text, forKey: "Quote")
        userDefaults.synchronize()
        
        return true
    }

}