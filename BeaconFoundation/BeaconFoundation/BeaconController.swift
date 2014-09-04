//
//  ViewController.swift
//  BeaconFoundation
//
//  Created by Josh Reese on 8/14/14.
//  Copyright (c) 2014 GPW. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconController: UIViewController {
                            
    @IBOutlet weak var webView: UIWebView!
    
    let mapURL = "http://www.gpwassociates.com/wpsite/wp-content/uploads/2014/03/GPW-Office-Map.jpg"
    
    func loadURL(){
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let URLString = appDelegate.curURL
        
        let requestURL = NSURL(string: URLString!)
        let request = NSURLRequest(URL: requestURL)
        webView.loadRequest(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.curView = self
        loadURL()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

