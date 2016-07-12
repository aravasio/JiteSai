//
//  RestManager.swift
//  JiteSai
//
//  Created by Alejandro on 7/11/16.
//  Copyright © 2016 aravasio. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ServiceResponse = (NSData, NSError?) -> Void

class RestManager {
    
    static let sharedInstance = RestManager()
    
    func getPlaces() {
        
    }
    
    func validateUser( email: String, password: String) {
        makeGetRequest( URL.base + URL.authenticate, body: "")
    }
    
    func registerUser() {
        
    }

    func processPayment() {
        
    }
    
    // MARK: Private methods
    
    private func makePOSTRequest() {
        
    }
    
    private func makeGetRequest(path: String, body: String) {
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            print(data)
            
        })
        task.resume()
    }
    
    private func makePostRequest(path: String, body: [String: AnyObject], onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        // Set the method to POST
        request.HTTPMethod = "POST"
        
//        do {
//            // Set the POST body for the request
//            let jsonBody = try NSJSONSerialization.dataWithJSONObject(body, options: .PrettyPrinted)
//            request.HTTPBody = jsonBody
//            let session = NSURLSession.sharedSession()
//            
//            let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//                if let jsonData = data {
//                    let json:JSON = JSON(data: jsonData)
//                    onCompletion(json, nil)
//                } else {
//                    onCompletion(nil, error)
//                }
//            })
//            task.resume()
//        } catch {
//            // Create your personal error
//            onCompletion(nil, nil)
//        }
    }
    
}