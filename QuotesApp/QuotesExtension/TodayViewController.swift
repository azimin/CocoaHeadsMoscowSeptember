//
//  TodayViewController.swift
//  QuotesExtension
//
//  Created by Alex Zimin on 02/10/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

import UIKit
import NotificationCenter

var containerName = "group.alex.quotes"

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        println("viewDidLoad")
        // Do any additional setup after loading the view from its nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        println("viewWillAppear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        println("viewDidDisappear")
    }
    
    override func viewDidAppear(animated: Bool) {
        println("viewDidDisappear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        println("viewWillDisappear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        let userDefaults = NSUserDefaults(suiteName: containerName)
        var text = "";
        if let info: String = userDefaults.objectForKey("Quote") as? String {
            text = info
        } else {
            text = "No info"
        }
        
        label.text = text
        
        let textHeigh = CGFloat(textHeight(text, font: label.font))
        self.preferredContentSize = CGSize(width: self.view.frame.width, height: textHeigh + 24)
        
        println(self.preferredContentSize)
        
        completionHandler(NCUpdateResult.NewData)
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        println(defaultMarginInsets)
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    private func textHeight(str: String, font: UIFont) -> Double {
        return attributedTextHeight(NSAttributedString(string: str, attributes: [NSFontAttributeName: font]))
    }
    
    private func attributedTextHeight(atrStr: NSAttributedString) -> Double {
        var size = CGSizeMake(self.label.frame.size.width, CGFloat.max)
        return Double(atrStr.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil).size.height)
    }
    
}
