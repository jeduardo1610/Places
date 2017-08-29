//
//  MapViewController.swift
//  Places
//
//  Created by Jorge Eduardo on 28/08/17.
//  Copyright © 2017 Jorge Eduardo. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {
    
    var place : Place!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(place.description)
        
        let geocoder = CLGeocoder()
        
        if(place != nil){
            
         geocoder.geocodeAddressString(place.location, completionHandler: { (placemarks, error) in
            if error == nil {
                for placemark in placemarks! {
                    print("Placemarks \(placemark)")
                    
                    //adding places with annotations
                    let annotation = MKPointAnnotation()
                    annotation.title = self.place.name
                    annotation.subtitle = self.place.type
                    annotation.coordinate = (placemark.location?.coordinate)!
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                    
                }
            } else {
                print("Something went wrong when parsing address \(error?.localizedDescription ?? "No error description found")")
            }
         })
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
