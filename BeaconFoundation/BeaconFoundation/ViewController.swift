//
//  ViewController.swift
//  BeaconFoundation
//
//  Created by Josh Reese on 8/14/14.
//  Copyright (c) 2014 GPW. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
                            
    @IBOutlet weak var webView: UIWebView!
    
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
        
        let uuidString = "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"
        let beaconIdentifier = "GPW_MAP"
        let beaconUUID:NSUUID = NSUUID(UUIDString: uuidString)
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, identifier:beaconIdentifier)
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let locationManager = appDelegate.locationManager
        
        //locationManager?.requestStateForRegion(beaconRegion)
        
        //let locationManagerDelegate = locationManager?.delegate
        //locationManagerDelegate?.locationManager!(locationManager, didDetermineState: CLRegionState.Unknown, forRegion: beaconRegion)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

