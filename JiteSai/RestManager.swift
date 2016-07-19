//
//  RestManager.swift
//  JiteSai
//
//  Created by Alejandro on 7/11/16.
//  Copyright © 2016 aravasio. All rights reserved.
//

import Foundation
import SwiftyJSON

//typealias ServiceResponse = (JSON, NSError?) -> Void

class RestManager {
    
    static let sharedInstance = RestManager()
    
    func getLocations( token: String, completionHandler: (JSON, String) -> Void ) {
        let url = URL.base + URL.places
        let headers = ["Authorization": token]
        
        makeGetRequest(url, headers: headers, onCompletion: { response, error in
            if error == nil {
                completionHandler(response, "")
            } else {
                completionHandler(["":""], error!.description)
            }
        })
        
    }
    
    func validateUser( email: String, password: String, completionHandler: (Bool, String) -> Void) {
        
        let validation = JSON( ["email": email, "password" : password] )

        makePostRequest(URL.base + URL.authenticate, headers: nil, body: validation, onCompletion: { response, error in
            if error == nil {
                let token = response["accessToken"].string
                completionHandler( true, token! )
            } else {
                completionHandler( false, error!.description )
            }
        })
    }
    
    func registerUser() {
        
    }

    func processPayment() {
        
    }
    
    // MARK: Private methods
    private func makeGetRequest(path: String, headers: [String: String]?, onCompletion: (JSON, NSError?) -> Void ) {
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        request.HTTPMethod = "GET"
        
        if( headers != nil ) {
            for header in headers! {
                request.addValue(header.1, forHTTPHeaderField: header.0)
            }
        }
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let jsonData = data {
                let json = JSON(data: jsonData)
                onCompletion(json, nil)
            } else {
                onCompletion(nil, error)
            }
        })
        task.resume()
    }
    
    private func makePostRequest(path: String, headers: [String: String]? , body: JSON?, onCompletion: (JSON, NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)

        do {
            request.HTTPMethod = "POST"
            
            if( headers != nil ) {
                for header in headers! {
                    request.addValue(header.1, forHTTPHeaderField: header.0)
                }
            }
            
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            if( body != nil ) {
                request.HTTPBody = try body!.rawData(options: .PrettyPrinted)
            }
            
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request, completionHandler: { data, response, error -> Void in
                if let jsonData = data {
                    let json = JSON(data: jsonData)
                    onCompletion(json, nil)
                } else {
                    onCompletion(nil, error)
                }
            })
            task.resume()
        } catch {
            // TODO: Handle errors somehow.
            onCompletion(nil, nil)
        }
    }
    
    
    // MARK: Helper functions
    private func addHeaders( headers: [String: String], inout toRequest: NSMutableURLRequest) {
        
        
    }

}