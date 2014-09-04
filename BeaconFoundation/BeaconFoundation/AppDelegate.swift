//
//  AppDelegate.swift
//  BeaconFoundation
//
//  Created by Josh Reese on 8/14/14.
//  Copyright (c) 2014 GPW. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    var curURL: NSString?
    var window: UIWindow?
    var locationManager: CLLocationManager?
    var lastProximity: CLProximity?
    var goneOutsideRange: Bool?
    var curView: UIViewController?
    
    
    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        
        let uuidString = "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"
        let beaconIdentifier = "GPW_Printer"
        let beaconUUID:NSUUID = NSUUID(UUIDString: uuidString)
        let beaconRegion:CLBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, identifier:beaconIdentifier)
        
        locationManager = CLLocationManager()
        if(locationManager!.respondsToSelector("requestAlwaysAuthorization")) {
            locationManager!.requestAlwaysAuthorization()
        }
        locationManager!.delegate = self
        locationManager!.pausesLocationUpdatesAutomatically = false
        
        locationManager!.startMonitoringForRegion(beaconRegion)
        locationManager!.startRangingBeaconsInRegion(beaconRegion)
        locationManager!.startUpdatingLocation()
        
        if(application.respondsToSelector("registerUserNotificationSettings:")) {
            
            var acceptAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
            acceptAction.identifier = "acceptAction"
            acceptAction.title = "Accept"
            
            acceptAction.activationMode = UIUserNotificationActivationMode.Foreground
            acceptAction.destructive = false
            acceptAction.authenticationRequired = false
            
            var declineAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
            declineAction.identifier = "declineAction"
            declineAction.title = "Decline"
            
            declineAction.activationMode = UIUserNotificationActivationMode.Background
            declineAction.destructive = false
            declineAction.authenticationRequired = false
            
            var rangedCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
            rangedCategory.identifier = "rangedCategory"
            
            let rangedActions:NSArray = [acceptAction, declineAction]
            
            rangedCategory.setActions(rangedActions, forContext: UIUserNotificationActionContext.Default)
            
            let categories:NSSet = NSSet(object: rangedCategory)
            
            let types:UIUserNotificationType = UIUserNotificationType.Alert
            
            let mySettings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: types, categories: categories)
            
            UIApplication.sharedApplication().registerUserNotificationSettings(mySettings)
        }
        
        return true
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        
        if(identifier == "declineAction"){
            return
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("notificationPressed", object: nil);

        
    }
    
    func applicationWillResignActive(application: UIApplication!) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication!) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication!) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication!) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication!) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

extension AppDelegate: CLLocationManagerDelegate {
    func sendLocalNotificationWithMessage(message: String!) {
        let notification:UILocalNotification = UILocalNotification()
        notification.category = "rangedCategory"
        notification.alertBody = message
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func locationManager(manager: CLLocationManager!,
        didRangeBeacons beacons: [AnyObject]!,
        inRegion region: CLBeaconRegion!) {
            
            NSLog("didRangeBeacons");
            var message:String = ""
            
            if(beacons.count > 0) {
                let nearestBeacon:CLBeacon = beacons[0] as CLBeacon
                
                let curProximity = nearestBeacon.proximity
                
                if(curProximity == lastProximity) {
                        return;
                }
                
                goneOutsideRange = false
                lastProximity = curProximity;
                
                switch curProximity {
                case CLProximity.Far:
                    
                    message = "You are far away from the beacon"
                    curURL = "http://oi62.tinypic.com/2ivmstz.jpg"
                case CLProximity.Near:
                    message = "You are near the beacon"
                    curURL = "http://oi58.tinypic.com/2r4udxv.jpg"
                case CLProximity.Immediate:
                    message = "You are in the immediate proximity of the beacon"
                    curURL = "http://oi57.tinypic.com/25qtdp4.jpg"
                case CLProximity.Unknown:
                    message = "Unknown beacon proximity"
                    curURL = "http://oi57.tinypic.com/jrsf82.jpg"
                }
            }
            else if(goneOutsideRange != true){
                lastProximity = CLProximity.Unknown
                goneOutsideRange = true
                message = "Outside Beacon Region"
                curURL = "http://oi57.tinypic.com/jrsf82.jpg"
            }
            else{
                return
            }
            
            if(curView?.restorationIdentifier == "beaconViewer"){
                let beaconView = curView as BeaconController
                beaconView.loadURL()
            }
            
            
            NSLog("%@", message)
            sendLocalNotificationWithMessage(message)
    }
    
    func locationManager(manager: CLLocationManager!,
        didDetermineState state: CLRegionState,
        forRegion region: CLRegion!){
            
    }
    
}

