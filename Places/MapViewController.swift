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
        
        self.mapView.delegate = self
        self.mapView.showsTraffic = true
        self.mapView.isZoomEnabled = true
        self.mapView.showsScale = true
        self.mapView.showsCompass = true
        
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

extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "CustomPin"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        //add place image to annotation pin
        var annotationView : MKPinAnnotationView? = self.mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 52, height: 52))
        imageView.image = self.place.image
        annotationView?.leftCalloutAccessoryView = imageView
        
        //change pin tint color
        annotationView?.pinTintColor = UIColor.green
        
        return annotationView
    }
}
