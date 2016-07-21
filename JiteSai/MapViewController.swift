//
//  ViewController.swift
//  JiteSai
//
//  Created by Alejandro on 7/10/16.
//  Copyright © 2016 aravasio. All rights reserved.
//

import UIKit
import GoogleMaps

class MainViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet var MapView: GMSMapView!
    @IBOutlet weak var OverlayView: UIView!
    
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var locationLatitudeLabel: UILabel!
    @IBOutlet weak var locationLongitudeLabel: UILabel!
    
    private var rest = RestManager.sharedInstance
    private var locations: Array<Location> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.OverlayView.hidden = true
        self.MapView.delegate = self
        
        setupCamera()
        
        rest.validateUser("test@test.com", password: "testpwd", completionHandler: { isValid, token in

            if ( isValid ) {
                self.validUser(token)
            } else {
                self.invalidUser()
            }

        })
    }
    
    private func validUser( token: String ) {
        //Retrieve map coordinates.
        rest.getLocations( token, completionHandler: { elementsIn, error in
            if error.isEmpty {
                for element in elementsIn["results"] {

                    if let location = Location(json: element.1) {
                        self.locations.append(location)
                        let coords = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                        //UI modifications ought to be made in the main thread.
                        dispatch_async(dispatch_get_main_queue(), {
                            let marker = GMSMarker(position: coords)
                            marker.title = location.name
                            marker.map = self.MapView
                        })
                    } else {
                        print("A location had an invalid value and therefore couldn't be created and displayed in the map.")
                    }
                }
            } else {
                print("The following error ocurred: " + error)
            }
        })
    }
    
    private func invalidUser() {
        // TODO: handle this.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
        
        if let location = (self.locations.filter{ $0.name == marker.title }).first {
            
            locationNameLabel.text = "Name: " + location.name
            locationLongitudeLabel.text = "Longitude: " + location.longitude.description
            locationLatitudeLabel.text = "Latitude: " + location.latitude.description
            showOverlay()
            
        }
        return true
    }
    
    @IBAction func closeOverlayButtonPressed(sender: UIButton) {
        hideOverlay()
    }
    
    // MARK: Utility methods
    
    private func setupCamera() {
        let camera = GMSCameraPosition.cameraWithLatitude(35.7090259, longitude: 139.7319925, zoom: 13)
        self.MapView.camera = camera
    }
    
    private func showOverlay() {
        
        // TODO: Maybe I can find a way to de-state this operation into something more generic?
        self.OverlayView.hidden = false
        self.OverlayView.transform = CGAffineTransformTranslate(self.OverlayView.transform, 0, self.OverlayView.frame.size.height)
        UIView.animateWithDuration(0.5, delay: 0.0, options: [], animations: {
            self.OverlayView.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
    
    private func hideOverlay() {
        
        // TODO: Maybe I can find a way to de-state this operation into something more generic?
//        self.OverlayView.transform = CGAffineTransformTranslate(self.OverlayView.transform, 0, 0)
        self.OverlayView.transform = CGAffineTransformIdentity
        UIView.animateWithDuration(0.5, delay: 0.0, options: [], animations: {
            self.OverlayView.transform = CGAffineTransformTranslate(self.OverlayView.transform, 0, self.OverlayView.frame.size.height)
            }, completion: { _ in
                self.OverlayView.hidden = true
        })
    }
}

