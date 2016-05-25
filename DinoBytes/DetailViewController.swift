//
//  DetailViewController.swift
//  DinoBytes
//
//  Created by Andrew Conrad on 5/24/16.
//  Copyright © 2016 AndrewConrad. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    let viewController = ViewController.sharedInstance
    let backendless = Backendless.sharedInstance()
    var dinosArray = [Dino]()
    var selectedDino : Dino?
    
    @IBOutlet weak var dinoNameNav          :UINavigationItem!
    @IBOutlet weak var dinoDescText         :UITextView!
    @IBOutlet weak var dinoDietText         :UITextView!
    @IBOutlet weak var dinoWeightLabel      :UILabel!
    @IBOutlet weak var dinoHeightLabel      :UILabel!
    @IBOutlet weak var dinoPicView          :UIImageView!
    
    
    
    func findDinos() {
        let dataQuery = BackendlessDataQuery()
        let whereClause = "beaconName = '\(viewController.selectedDino)'"
        dataQuery.whereClause = whereClause
        var error: Fault?
        let bc = backendless.data.of(Dino.ofClass()).find(dataQuery, fault: &error)
        if error == nil {
            dinosArray = bc.getCurrentPage() as! [Dino]
        } else {
            print("Found Error \(error)")
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        findDinos()
    }
    
    override func viewWillAppear(animated: Bool) {
        dinoNameNav.title = selectedDino?.dinoName
        dinoDescText.text = selectedDino?.dinoDesc
        dinoDietText.text = selectedDino?.dinoDiet
        dinoWeightLabel.text = selectedDino?.dinoWeight
        dinoHeightLabel.text = selectedDino?.dinoHeight
        //ADD DINO PICS IN ONCE I CAN TELL IF THIS WORKS
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
