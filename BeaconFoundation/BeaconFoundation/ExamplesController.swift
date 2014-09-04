//
//  ExamplesController.swift
//  BeaconFoundation
//
//  Created by Philip Read on 9/3/14.
//  Copyright (c) 2014 GPW. All rights reserved.
//

import UIKit

class ExamplesController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.curView = self
        
        let URLString = "http://www.gpwassociates.com/wpsite/about/scope-of-services/"
        
        let requestURL = NSURL(string: URLString)
        let request = NSURLRequest(URL: requestURL)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
