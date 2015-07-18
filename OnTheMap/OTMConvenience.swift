//
//  OTMConvenience.swift
//  On The Map
//
//  Created by Arsalan Akhtar on 01/07/2015.
//  Copyright (c) 2015 Arsalan Akhtar. All rights reserved.
//

import Foundation
import UIKit

extension OTMClient {
    
    
    //Mark: -GET Convenience Methods
    func getStudentLocations(completionHandler: (result: [OTMStudentLocation]?, error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
//        let parameters = [OTMClient.ParameterKeys.Limit: "100"]
        
        let parameters = [String:AnyObject]()
        
        var mutableMethod : String = Methods.StudentLocations
        
        
        /* 2. Make the request */
        let baseurl = Constants.ParseBaseURL
        
        var request = NSMutableURLRequest()
        
        request.addValue(OTMClient.Constants.ParseApiKey, forHTTPHeaderField:OTMClient.ParameterKeys.ParseApiKey)
        request.addValue(OTMClient.Constants.ParseAppID, forHTTPHeaderField:OTMClient.ParameterKeys.ParseApplicationID)
        
        taskForGETMethod(request, baseurl: baseurl, method: mutableMethod, parameters: parameters){ JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                
                if let results = JSONResult.valueForKey(OTMClient.JsonResponseKeys.Results) as?
                    
                    [[String : AnyObject]] {
                    
                    var studentLocations = OTMStudentLocation.studentLocationsFromResults(results)
                    
                    completionHandler(result: studentLocations, error: nil)
                } else {
                    completionHandler(result: nil, error: NSError(domain: "getStudentLocationResult parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse studentLocation"]))
                }
            }
        }
    }

    
    func getUserDetails(completionHandler: (result: OTMUser?, error: NSError?) -> Void) {
    
        
            
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        //        let parameters = [OTMClient.ParameterKeys.Limit: "100"]
        
        let parameters = [String:AnyObject]()
        
        var mutableMethod : String = Methods.User
         mutableMethod = OTMClient.subtituteKeyInMethod(mutableMethod, key: OTMClient.UrlKeys.UserID, value: String(OTMClient.sharedInstance().userID!))!
        
        /* 2. Make the request */
        let baseurl = Constants.UdacityBaseURL
        
        var request = NSMutableURLRequest()
        
        
        taskForGETMethod(request, baseurl: baseurl, method: mutableMethod, parameters: parameters){ JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                
                if let results : NSDictionary = JSONResult.valueForKey(OTMClient.JsonResponseKeys.User) as? [String : AnyObject] {
                    
                    OTMClient.sharedInstance().userDetails?.firstName = results.valueForKey("firstname") as! String!
                    OTMClient.sharedInstance().userDetails?.lastName = results.valueForKey("lastname") as! String!
                    
                    completionHandler(result: OTMClient.sharedInstance().userDetails, error: nil)
                    
                } else {
                    completionHandler(result: nil, error: NSError(domain: "getStudentLocationResult parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse studentLocation"]))
                }
            }
        }
    }

    
   
    // MARK: - POST Convenience Methods
    
    func authenticateWithPassword(email: String,Password : String, completionHandler: (result: Int?, error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        var parameters = [String: AnyObject]()
        var mutableMethod : String = Methods.Session
        
        let jsonBodyCredentials : [String:AnyObject] = [
            OTMClient.JsonBodyKeys.Username: email,
            OTMClient.JsonBodyKeys.Password: Password
        ]
        
        let jsonBody : [String:AnyObject] = [
            OTMClient.JsonBodyKeys.Udacity:jsonBodyCredentials
        ]
        
        let baseurl = Constants.UdacityBaseURL

        var request = NSMutableURLRequest()
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        /* 2. Make the request */
        
        let task = taskForPOSTMethod(request, baseurl: baseurl, method: mutableMethod, parameters: parameters, jsonBody: jsonBody){ JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
               
            if let resultDictionary = JSONResult.valueForKey(OTMClient.JsonResponseKeys.Account) as? NSDictionary {
                
                if let results = resultDictionary.valueForKey(OTMClient.JsonResponseKeys.Registered) as? Int {
                    
                        self.userID = resultDictionary.valueForKey(OTMClient.JsonResponseKeys.Key) as? String
                        completionHandler(result: results, error: nil)
                    }
                }
                else {
                
                
                var erroreee = ""
                if let errorString = JSONResult.valueForKey(OTMClient.JsonResponseKeys.Error) as? String{
                           erroreee =  errorString
                }
                
                
                    completionHandler(result: nil, error: NSError(domain: "Login", code: 0, userInfo: [NSLocalizedDescriptionKey: erroreee]))
                }
            }
        }
    }
    
    //
    
    
    func postUserLocation(uniqueKey: String,firstName : String,lastName : String,mapString : String, mediaUrl : String, latitude : Double, longitude : Double, completionHandler: (result: Int?, error: NSError?) -> Void) {
        
        
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        var parameters = [String: AnyObject]()
        var mutableMethod : String = Methods.Session
        
        
        let jsonBody : [String:AnyObject] = [
            OTMClient.JsonBodyKeys.UniqueKey:uniqueKey,
            OTMClient.JsonBodyKeys.FirstName:firstName,
            OTMClient.JsonBodyKeys.LastName:lastName,
            OTMClient.JsonBodyKeys.MapString:mapString,
            OTMClient.JsonBodyKeys.MediaURL:mediaUrl,
            OTMClient.JsonBodyKeys.Latitude:latitude,
            OTMClient.JsonBodyKeys.Longitude:longitude
        ]
        
        let baseurl = Constants.ParseBaseURL
        
        var request = NSMutableURLRequest()
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.addValue(OTMClient.Constants.ParseApiKey, forHTTPHeaderField:OTMClient.ParameterKeys.ParseApiKey)
        request.addValue(OTMClient.Constants.ParseAppID, forHTTPHeaderField:OTMClient.ParameterKeys.ParseApplicationID)
        
        /* 2. Make the request */
        
        let task = taskForPOSTMethod(request, baseurl: baseurl, method: mutableMethod, parameters: parameters, jsonBody: jsonBody){ JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                
                if let resultDictionary = JSONResult.valueForKey(OTMClient.JsonResponseKeys.Account) as? NSDictionary {
                    
                    if let results = resultDictionary.valueForKey(OTMClient.JsonResponseKeys.Registered) as? Int {
                        
                        completionHandler(result: results, error: nil)
                    }
                }
                else {
                    
                    
                    var tempError = ""
                    if let errorString = JSONResult.valueForKey(OTMClient.JsonResponseKeys.Error) as? String{
                        tempError =  errorString
                    }
                    
                    
                    completionHandler(result: nil, error: NSError(domain: "Login", code: 0, userInfo: [NSLocalizedDescriptionKey: tempError]))
                }
            }
        }
    }
}