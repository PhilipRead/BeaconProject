//
//  MainMenu.swift
//  BeaconFoundation
//
//  Created by Philip Read on 8/22/14.
//  Copyright (c) 2014 GPW. All rights reserved.
//

import UIKit

class MainMenu: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var subMenuNames = [ "About", "Work Examples", "Find GPW", "Call", "Email", "Beacon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.curView = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "moveToBeaconOutput:", name: "notificationPressed", object: nil)
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.curView = self
    }
    
    func moveToBeaconOutput(notification: NSNotification){
        var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if(appDelegate.curView?.restorationIdentifier == "beaconOutput"){
            return
        }
        else if(appDelegate.curView?.restorationIdentifier != "mainMenu"){
            appDelegate.curView?.navigationController?.popViewControllerAnimated(true)
        }
        
        appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let tempString = appDelegate.curView?.restorationIdentifier
        NSLog(tempString!)
        
        self.performSegueWithIdentifier("toBeaconOutput", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subMenuNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel?.text = self.subMenuNames[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let curCell = tableView.cellForRowAtIndexPath(indexPath)
        
        if(curCell?.textLabel?.text == "About"){
            self.performSegueWithIdentifier("toAbout", sender: self)
        }
        else if(curCell?.textLabel?.text == "Work Examples"){
            self.performSegueWithIdentifier("toExamples", sender: self)
        }
        else if(curCell?.textLabel?.text == "Find GPW"){
            self.performSegueWithIdentifier("toMap", sender: self)
        }
        else if(curCell?.textLabel?.text == "Call"){
            
        }
        else if(curCell?.textLabel?.text == "Email"){
            
        }
        else if(curCell?.textLabel?.text == "Beacon"){
            self.performSegueWithIdentifier("toBeaconOutput", sender: self)
        }
        
        curCell?.setSelected(false, animated: true)
    }
}

