//
//  NightClubRatingViewController.swift
//  Assignment #2
//
//  Created by Voss, Garrett on 5/7/18.
//  Copyright © 2018 Voss, Garrett. All rights reserved.
//

import UIKit
import CoreData

class NightClubRatingViewController: UIViewController {
    
    var currentClub: NightClub?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var lblBeerRating: UILabel!
    @IBOutlet weak var lblwineRating: UILabel!
    @IBOutlet weak var lblMusicRating: UILabel!
    @IBOutlet weak var stprBeer: UIStepper!
    @IBOutlet weak var stprWine: UIStepper!
    @IBOutlet weak var stprMusic: UIStepper!
    
    @IBAction func beerRatingChanged(_ sender: Any) {
        lblBeerRating.text = String(stprBeer.value)
    }
    
    @IBAction func wineRatingChanged(_ sender: Any) {
        lblwineRating.text = String(stprWine.value)
    }
        
    @IBAction func musicRatingChanged(_ sender: Any) {
        lblMusicRating.text = String(stprMusic.value)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblBeerRating.text = currentClub?.beer
        lblwineRating.text = currentClub?.wine
        lblMusicRating.text = currentClub?.music
        
        let saveButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(saveRating))
        self.navigationItem.rightBarButtonItem = saveButton
        self.title = currentClub?.name
        

        // Do any additional setup after loading the view.
    }
    
    @objc func saveRating() {
        currentClub?.beer = lblBeerRating.text
        currentClub?.wine = lblwineRating.text
        currentClub?.music = lblMusicRating.text
        currentClub?.average = String(format: "%.2f", AverageRating())
        appDelegate.saveContext()
        self.navigationController?.popViewController(animated: true)
    }
    
    func AverageRating () -> Double {
        let beerRating = Double(lblBeerRating.text!)
        let wineRating = Double(lblwineRating.text!)
        let musicRating = Double(lblMusicRating.text!)
        let averageRating = ((beerRating! + wineRating! + musicRating!) / 3)
        return averageRating
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
