//
//  ViewController.swift
//  JiteSai
//
//  Created by Alejandro on 7/10/16.
//  Copyright © 2016 aravasio. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    @IBOutlet var MapView: GMSMapView!
    
    private var rest = RestManager.sharedInstance
    private var locations: Array<Location> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.cameraWithLatitude(35.7090259,
                                                          longitude: 139.7319925, zoom: 16)
        self.MapView.camera = camera
        
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
    
}

