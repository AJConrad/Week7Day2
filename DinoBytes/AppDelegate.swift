//
//  AppDelegate.swift
//  DinoBytes
//
//  Created by Andrew Conrad on 5/24/16.
//  Copyright © 2016 AndrewConrad. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTBeaconManagerDelegate {
    
    let APP_ID = "03CEDF98-0987-5039-FF09-207AFBF3EC00"
    let SECRET_KEY = "BDFF0833-FB42-05A5-FF49-2F3D1D5E6100"
    //CHANGE THESE KEYS TO BE WHAT THIS APP USES
    let VERSION_NUM = "v1"
    let backendless = Backendless.sharedInstance()
    
    var window: UIWindow?
    let beaconManager = ESTBeaconManager()
    var lastRegion: CLBeaconRegion?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        backendless.initApp(APP_ID, secret: SECRET_KEY, version: VERSION_NUM)
        beaconManager.delegate = self
        checkForLocationAuthorization()
        return true
    }
}

extension AppDelegate {
    
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if beacons.count > 0 {
            let nearestBeacon = beacons[0]
            if region != lastRegion {
                switch nearestBeacon.proximity {
                case .Immediate:
                    NSNotificationCenter.defaultCenter().postNotificationName("didRangeBeaconMSG", object: nil, userInfo: ["region":region.identifier])
                    print("Ranged Immediate \(region.identifier)")
                    
    //I ONLY CARE ABOUT THE IMMEDIATE
//                case .Near:
//                    print("Ranged Near \(region.identifier)")
//                case .Far:
//                    print("Ranged Far \(region.identifier)")
//                case .Unknown:
//                    print("Range Unknown")
                default:
                    print("Moving")
                }
                lastRegion = region
            }
        }
    }
    //USEFUL FOR ENTERING OR EXITING MUSEUM
//    func beaconManager(manager: AnyObject, didDetermineState state: CLRegionState, forRegion region: CLBeaconRegion) {
//        switch state{
//        case .Unknown:
//            print("Region \(region.identifier) Unknown")
//        case .Inside:
//            print("Region \(region.identifier) Inside")
//        case .Outside:
//            print("Region \(region.identifier) Outside")
//        }
//    }
    //DONT NEED ENTER REGION, NEED NEAR
//    func beaconManager(manager: AnyObject, didEnterRegion region: CLBeaconRegion) {
//        print("Did enter \(region.identifier)")
//    }
    
    //DONT NEED DID EXIT
//    func beaconManager(manager: AnyObject, didExitRegion region: CLBeaconRegion) {
//        print("Did exit \(region.identifier)")
//    }
    
    func setUpBeacons() {
        print("Setting Up Beacons")
        let uuidString = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
        let beaconUUID = NSUUID(UUIDString: uuidString)!
        
        let beaconIdentifier = "IronYard"
        let allBeaconsRegion = CLBeaconRegion(proximityUUID: beaconUUID, identifier: beaconIdentifier)
        beaconManager.startMonitoringForRegion(allBeaconsRegion)
        
        let beacon1major :CLBeaconMajorValue = 39380
        let beacon1minor :CLBeaconMinorValue = 44024
        let beacon1Identifier = "PurpleBeaconDino"
        let purpleBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, major: beacon1major, minor: beacon1minor, identifier: beacon1Identifier)
        beaconManager.startRangingBeaconsInRegion(purpleBeaconRegion)
        
        let beacon2major :CLBeaconMajorValue = 31640
        let beacon2minor :CLBeaconMinorValue = 65404
        let beacon2Identifier = "BlueBeaconDino"
        let blueBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, major: beacon2major, minor: beacon2minor, identifier: beacon2Identifier)
        beaconManager.startRangingBeaconsInRegion(blueBeaconRegion)
        
        let beacon3major :CLBeaconMajorValue = 34909
        let beacon3minor :CLBeaconMinorValue = 15660
        let beacon3Identifier = "MintBeaconDino"
        let mintBeaconRegion = CLBeaconRegion(proximityUUID: beaconUUID, major: beacon3major, minor: beacon3minor, identifier: beacon3Identifier)
        beaconManager.startRangingBeaconsInRegion(mintBeaconRegion)
    }
    
    func checkForLocationAuthorization(){
        if CLLocationManager.locationServicesEnabled() {
            print("Loc Services On!")
            switch ESTBeaconManager.authorizationStatus() {
            case .AuthorizedAlways, .AuthorizedWhenInUse:
                print("Start Up")
                setUpBeacons()
            case .Denied, .Restricted:
                print("Turn on location in settings")
            case .NotDetermined:
                print("Not Determined")
                if beaconManager.respondsToSelector(#selector(CLLocationManager.requestAlwaysAuthorization)) {
                    print("Requesting Always")
                    beaconManager.requestAlwaysAuthorization()
                }
            }
        }else {
            print("Turn on Location Services")
        }
    }
    
    func beaconManager(manager: AnyObject, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("Did Change Authorization")
        checkForLocationAuthorization()
    }
    
}

