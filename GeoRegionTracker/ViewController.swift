//
//  ViewController.swift
//  GeoRegionTracker
//
//  Created by Robert Sieh on 4/19/15.
//  Copyright (c) 2015 Robert Sieh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        var camera = GMSCameraPosition.cameraWithLatitude(34.021304, longitude: -118.282489, zoom: 20)
        mapView.camera = camera
        //var mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.mapType = kGMSTypeHybrid
        
        //self.view = mapView
        
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(34.021304, -118.282489)
        marker.title = "my "
        marker.snippet = "room"
        marker.map = mapView
        
        var circle = GMSCircle(position: marker.position, radius: 30)
        circle.title = "bounds"
        circle.map = mapView
        circle.tappable = true
        
        locationManager.startMonitoringForRegion(convertCircle(circle, id: "first"))
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            
            mapView.myLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func convertCircle(toConvert : GMSCircle, id: String) -> CLCircularRegion{
        return CLCircularRegion(center: toConvert.position, radius: toConvert.radius, identifier: id)
    }
    

}

