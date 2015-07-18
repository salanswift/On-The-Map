//
//  OTMClient.swift
//  On The Map
//
//  Created by Arsalan Akhtar on 01/07/2015.
//  Copyright (c) 2015 Arsalan Akhtar. All rights reserved.
//

import Foundation

class OTMClient : NSObject {
    
    /* Shared session */
    var session: NSURLSession
    
    /*Shared Location Array*/
     var locations: [OTMStudentLocation] = [OTMStudentLocation]()
    
    /*Shared User Detail */
    var userDetails : OTMUser? = nil
    
    
    /* Authentication state */
    var sessionID : String? = nil
    var userID : String? = nil
    
    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }
    
    // Mark : GET
    
    func taskForGETMethod(request:NSMutableURLRequest, baseurl : String,method: String, parameters: [String : AnyObject], completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        /* 1. Set the parameters */
        var mutableParameters = parameters
        
        /* 2/3. Build the URL and configure the request */
        let urlString = baseurl + method + OTMClient.escapedParameters(mutableParameters)
        let url = NSURL(string: urlString)!
        let request = request
        
        request.URL = url
        /* 4. Make the request */
        let task = session.dataTaskWithRequest(request) {data, response, downloadError in
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            if let error = downloadError {
                let newError = OTMClient.errorForData(data, response: response, error: error)
                completionHandler(result: nil, error: downloadError)
            } else {
                 println(NSString(data: data, encoding: NSUTF8StringEncoding))
                
                let newData : NSData?
                
                if baseurl.rangeOfString(Constants.UdacityBaseURL) != nil{
                    
                    newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
                    
                    (completionHandler:data)
                    }else{
                    newData = data
               }
                
                OTMClient.parseJSONWithCompletionHandler(newData!, completionHandler: completionHandler)
            }
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
        
        }

    // Mark : POST
    
    func taskForPOSTMethod(request:NSMutableURLRequest, baseurl : String,method: String, parameters: [String : AnyObject], jsonBody: [String:AnyObject], completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        
        /* 1. Set the parameters */
        var mutableParameters = parameters
        
        /* 2/3. Build the URL and configure the request */
        let urlString = baseurl + method + OTMClient.escapedParameters(mutableParameters)
        let url = NSURL(string: urlString)!
        var request = request
       
        request.URL = url
        
        
        var jsonifyError: NSError? = nil
        request.HTTPMethod = "POST"
        
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(jsonBody, options: nil, error: &jsonifyError)
        
        /* 4. Make the request */
        let task = session.dataTaskWithRequest(request) {data, response, downloadError in
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            if let error = downloadError {
                let newError = OTMClient.errorForData(data, response: response, error: error)
                completionHandler(result: nil, error: downloadError)
            } else {
                
                let newData : NSData?
                
                if baseurl.rangeOfString(Constants.UdacityBaseURL) != nil{
                    newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
                }else{
                    newData = data
                }
                
                OTMClient.parseJSONWithCompletionHandler(newData!, completionHandler: completionHandler)
            }
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    
    /* Helper: Substitute the key for the value that is contained within the method name */
    class func subtituteKeyInMethod(method: String, key: String, value: String) -> String? {
        if method.rangeOfString("{\(key)}") != nil {
            return method.stringByReplacingOccurrencesOfString("{\(key)}", withString: value)
        } else {
            return nil
        }
    }
    
    /* Helper: Given a response with error, see if a status_message is returned, otherwise return the previous error */
    class func errorForData(data: NSData?, response: NSURLResponse?, error: NSError) -> NSError {
        
        if let parsedResult = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil) as? [String : AnyObject] {
            
            if let errorMessage = parsedResult[OTMClient.JsonResponseKeys.StatusMessage] as? String {
                
                let userInfo = [NSLocalizedDescriptionKey : errorMessage]
                
                return NSError(domain: "OTM Error", code: 1, userInfo: userInfo)
            }
        }
        
        return error
    }

    /* Helper: Given raw JSON, return a usable Foundation object */
    class func parseJSONWithCompletionHandler(data: NSData, completionHandler: (result: AnyObject!, error: NSError?) -> Void) {
        
        println(NSString(data: data, encoding: NSUTF8StringEncoding))
        var parsingError: NSError? = nil
        
        let parsedResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError)
        
        if let error = parsingError {
            completionHandler(result: nil, error: error)
        } else {
            completionHandler(result: parsedResult, error: nil)
        }
    }
    
    

    /* Helper function: Given a dictionary of parameters, convert to a string for a url */
    class func escapedParameters(parameters: [String : AnyObject]) -> String {
        
        var urlVars = [String]()
        
        for (key, value) in parameters {
            
            /* Make sure that it is a string value */
            let stringValue = "\(value)"
            
            /* Escape it */
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            /* Append it */
            urlVars += [key + "=" + "\(escapedValue!)"]
            
        }
        
        return (!urlVars.isEmpty ? "?" : "") + join("&", urlVars)
    }
    

    // MARK: - Shared Instance
    
    class func sharedInstance() -> OTMClient {
        
        struct Singleton {
            static var sharedInstance = OTMClient()
        }
        
        return Singleton.sharedInstance
    }

}