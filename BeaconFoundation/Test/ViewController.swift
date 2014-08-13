//
//  ViewController.swift
//  BeaconFoundation
//
//  Created by Philip Read on 8/10/14.
//  Copyright (c) 2014 GPW. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{
    
    @IBOutlet var webView: UIWebView
    
    let mapURL = "http://www.gpwassociates.com/wpsite/wp-content/uploads/2014/03/GPW-Office-Map.jpg"
    let outOfRangeURL = "http://www.google.com"
    
    func loadMap() {
        let requestURL = NSURL(string:mapURL)
        let request = NSURLRequest(URL: requestURL)
        webView.loadRequest(request)
    }
    
    func outOfRange() {
        let requestURL = NSURL(string:outOfRangeURL)
        let request = NSURLRequest(URL: requestURL)
        webView.loadRequest(request)
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

