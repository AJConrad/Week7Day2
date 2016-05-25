//
//  ViewController.swift
//  DinoBytes
//
//  Created by Andrew Conrad on 5/24/16.
//  Copyright © 2016 AndrewConrad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    static let sharedInstance = ViewController()
    let backendless = Backendless.sharedInstance()
    var selectedDino : String!
    
    //Intro Screen Methods + Segues

//    func findDinos() {
//        let dataQuery = BackendlessDataQuery()
//        let whereClause = "beaconName = '\(selectedDino!.objectId)'"
//        dataQuery.whereClause = whereClause
//        var error: Fault?
//        let bc = backendless.data.of(Dino.ofClass()).find(dataQuery, fault: &error)
//        if error == nil {
//            dinosArray = bc.getCurrentPage() as! [Dino]
//        } else {
//            print("Found Error \(error)")
//        }
//    }
    
//    override func prepareForSegue(segue:UIStoryboardSegue, sender: AnyObject?) {
//        
//        if segue.identifier == "Dino" {
//            let destController = segue.destinationViewController as! DetailViewController
//            let selectedDino = dinosArray[0]
//            
//        }
//    }
    
    func showDinoScreen(notification: NSNotification) {
        if let nearBeacon = notification.userInfo?["region"] {
            print("Beacon: \(nearBeacon.region!.identifier)")
            selectedDino = nearBeacon.region!.identifier
            performSegueWithIdentifier("Dino", sender: self)
            
//            let destController = segue.destinationViewController as! DetailViewController
//            let selectedDino = dinosArray[0]
        }
    }
    
    //TEMP ADD RECORDS START

//    func tempAddRecordsPurple() {
    
    //
    //THESE REALLY WONT WORK ANYMORE SINCE I CHANGED SELECTEDDINO AT THE TOP TO BE A STRING TO PASS OVER TO THE NEXT VC
    //
//        
//        let newDino = Dino()
//        selectedDino?.dinoName = "Stegosaurus"
//        selectedDino?.dinoDesc = "Big Old Beast"
//        selectedDino?.dinoHeight = "Tall"
//        selectedDino?.dinoWeight = "Fat"
//        selectedDino?.dinoDiet = "Veggies"
//        selectedDino?.dinoPic = "dinos.com"
//        selectedDino?.beaconName = "PurpleBeaconDino"
//        selectedDino = newDino
//        saveDino(selectedDino!)
//    }
//    
//    func tempAddRecordsBlue() {
//        
//        let newDino = Dino()
//        selectedDino?.dinoName = "Velociraptor"
//        selectedDino?.dinoDesc = "Pack Hunting Giant Chicken of Death"
//        selectedDino?.dinoHeight = "6 foot 2 inches"
//        selectedDino?.dinoWeight = "Fat"
//        selectedDino?.dinoDiet = "People"
//        selectedDino?.dinoPic = "dinos.com"
//        selectedDino?.beaconName = "BlueBeaconDino"
//        selectedDino = newDino
//        saveDino(selectedDino!)
//    }
//    
//    func tempAddRecordsMint() {
//        
//        let newDino = Dino()
//        selectedDino?.dinoName = "Spinosaurus"
//        selectedDino?.dinoDesc = "SCARY MASSIVE RAWR"
//        selectedDino?.dinoHeight = "REALLY Tall"
//        selectedDino?.dinoWeight = "VERY Large"
//        selectedDino?.dinoDiet = "People are not enough meat, so it will not waste time on you."
//        selectedDino?.dinoPic = "dinos.com"
//        selectedDino?.beaconName = "MintBeaconDino"
//        selectedDino = newDino
//        saveDino(selectedDino!)
//    }
//    
//    func saveDino(dino: Dino) {
//        let dataStore = backendless.data.of(Dino.ofClass())
//        dataStore.save(dino, response: { (response) in
//            print("Dino Saved")
//        }) { (error) in
//            print("Dino not saved, error \(error)")
//        }
//    }
    
    //TEMP ADD RECORDS END
    
    //MARK: - Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(showDinoScreen), name: "didRangeBeaconMSG", object: nil)
        
//        tempAddRecordsBlue()
//        tempAddRecordsMint()
//        tempAddRecordsPurple()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


