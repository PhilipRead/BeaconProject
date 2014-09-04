//
//  MapController.swift
//  BeaconFoundation
//
//  Created by Philip Read on 9/1/14.
//  Copyright (c) 2014 GPW. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var latitude:CLLocationDegrees = 38.965427
        var longitude:CLLocationDegrees = -95.234866
        
        var latDeltaZoom:CLLocationDegrees = 0.01
        var longDeltaZoom:CLLocationDegrees = 0.01
        
        var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDeltaZoom, longDeltaZoom)
        
        var GPWLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(GPWLocation, theSpan)
        
        self.mapView.setRegion(theRegion, animated: true)
        
        var GPW_Pin = MKPointAnnotation()
        
        GPW_Pin.coordinate = GPWLocation
        
        GPW_Pin.title = "GPW & Associates"
        GPW_Pin.subtitle = "1001 New Hampshire St\nLawrence, KS 66044\n(785) 865-2332"
        
        self.mapView.addAnnotation(GPW_Pin)
        
        self.mapView.selectAnnotation(GPW_Pin, animated: true)
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.curView = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
