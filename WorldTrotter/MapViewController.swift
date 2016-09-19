//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Benjamin Allgeier on 9/15/16.
//  Copyright © 2016 ballgeier. All rights reserved.
//

//import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        
        // set it as *the* view of this view controller
        view = mapView
        
        //        let segmentedControl =
        //            UISegmentedControl(items: ["Standard", "Hybird", "Satellite"])
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let hybirdString = NSLocalizedString("Hybird", comment: "Hybird map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let segmentedControl = UISegmentedControl(items: [standardString, hybirdString, satelliteString])
        
        segmentedControl.backgroundColor =
            UIColor.white.withAlphaComponent(0.5)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        //        let topConstraint =
        //            segmentedControl.topAnchor.constraintEqualToAnchor(view.topAnchor)
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        //        let leadingConstraint =
        //            segmentedControl.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor)
        //        let trailingConstraint = segmentedControl.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)),
                                   for: .valueChanged)
        
        // want to create a button that displays and zooms in on user's location
        
        let findMeButton = UIButton(type: UIButtonType.system)
        findMeButton.translatesAutoresizingMaskIntoConstraints = false
        findMeButton.setImage(UIImage(named: "NavigationIcon"), for: UIControlState.normal)
        findMeButton.addTarget(self, action: #selector(findUserLocation(_:)), for: UIControlEvents.touchUpInside)
        view.addSubview(findMeButton)
        findMeButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: 8).isActive = true
        findMeButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        let locationAuthStatus = CLLocationManager.authorizationStatus() // note a type method
        // not an instance method
        locationManager.delegate = self
        if locationAuthStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } // end if
        
        if CLLocationManager.locationServicesEnabled() {
            mapView.showsUserLocation = true
            mapView.setUserTrackingMode(.follow, animated: true)
            print("Shows user location: \(mapView.showsUserLocation)")
            print("Is user's location showing on map: \(mapView.isUserLocationVisible)")
            
        } // end if
        
    } // end loadView
    
    func findUserLocation(_ button: UIButton) {
        print("You found me")
    }
    
    func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    } // end mapTypeChanged
    
    override func viewDidLoad() {
        // Always call the super implementation of viewDidLoad
        super.viewDidLoad()
        
        print("MapViewController loaded its view")
    } // end viewDidLoad
    
} // end MapViewController
