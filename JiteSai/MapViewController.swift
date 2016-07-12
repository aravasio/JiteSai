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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        rest.validateUser("", password: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

