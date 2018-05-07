//
//  ViewController.swift
//  Assignment #2
//
//  Created by Voss, Garrett on 5/7/18.
//  Copyright © 2018 Voss, Garrett. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    
    var currentClub: NightClub?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var txtClubName: UITextField!
    @IBOutlet weak var txtClubStreet: UITextField!
    @IBOutlet weak var txtClubCity: UITextField!
    @IBOutlet weak var txtClubState: UITextField!
    @IBOutlet weak var txtClubZip: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func SaveClub(_ sender: Any) {
        let context = appDelegate.persistentContainer.viewContext
        currentClub = NightClub(context: context)
        currentClub?.name = txtClubName.text
        currentClub?.streetAddress = txtClubStreet.text
        currentClub?.city = txtClubCity.text
        currentClub?.state = txtClubState.text
        currentClub?.zipcode = txtClubZip.text
        currentClub?.beer = "1.0"
        currentClub?.wine = "1.0"
        currentClub?.music = "1.0"
        currentClub?.average = "1.0"
        appDelegate.saveContext()
        txtClubName.text = ""
        txtClubStreet.text = ""
        txtClubCity.text = ""
        txtClubState.text = ""
        txtClubZip.text = ""
    }
    
    @IBAction func CancelClub(_ sender: Any) {
        txtClubName.text = ""
        txtClubStreet.text = ""
        txtClubCity.text = ""
        txtClubState.text = ""
        txtClubZip.text = ""
    }
}

