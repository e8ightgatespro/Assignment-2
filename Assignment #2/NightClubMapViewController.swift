//
//  NightClubMapViewController.swift
//  Assignment #2
//
//  Created by Voss, Garrett on 5/7/18.
//  Copyright © 2018 Voss, Garrett. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class NightClubMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
   
    @IBOutlet weak var mapView: MKMapView!
    
    var clubs: [NightClub] = []
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "NightClub")
        var fetchedObjects: [NSManagedObject] = []
        do {
            fetchedObjects = try context.fetch(request)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        clubs = fetchedObjects as! [NightClub]
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        for club in clubs {
            let address = "\(club.streetAddress!), \(club.city!), \(club.state!)"
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(address) { (placemarks, error) in
                self.processAddressResponse(club, withPlacemarks: placemarks, error: error)
            }
        }
    }
    
    func processAddressResponse(_ club: NightClub, withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        if let error = error {
            print("Geocode Error: \(error)")
        }
        else {
            var bestMatch: CLLocation?
            if let placemarks = placemarks, placemarks.count > 0 {
                bestMatch = placemarks.first?.location
            }
            if let coordinate = bestMatch?.coordinate {
                let mp = MapPoint(latitude: coordinate.latitude, longitude: coordinate.longitude)
                mp.title = club.name
                mp.subtitle = "Average Rating: \(club.average ?? "0")"
                mapView.addAnnotation(mp)
            }
            else {
                print("Didn't find any matching locations")
            }
        }
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
