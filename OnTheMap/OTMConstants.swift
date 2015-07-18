//
//  OTMConstants.swift
//  On The Map
//
//  Created by Arsalan Akhtar on 01/07/2015.
//  Copyright (c) 2015 Arsalan Akhtar. All rights reserved.
//

extension OTMClient {

    struct Constants{
    //Mark : API Key
    static let UdacityFacebookAppID = "365362206864879"
    
    static let ParseAppID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        
    static let ParseApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
        
    //Mark : Base URLs
    static let ParseBaseURL = "https://api.parse.com/1/"
    
    static let UdacityBaseURL = "https://www.udacity.com/api/"
    
   }
   
    struct Methods{
    
    static let Session = "session"
    
    static let StudentLocations = "classes/StudentLocation"
        
    static let UpdatingStudentLocation = "classes/studentlocation/{id}"
        
    static let User = "users/{id}"
        
    }
    
    struct JsonBodyKeys {
    
    static let UniqueKey = "uniqueKey"

    static let FirstName = "firstName"
        
    static let LastName  = "lastName"
        
    static let MapString = "mapString"
        
    static let MediaURL = "mediaURL"
        
    static let Latitude = "latitude"
    
    static let Longitude = "longitude"
        
    static let Udacity = "udacity"
        
    static let Username = "username"
        
    static let Password = "password"
        
    static let FacebookMobile = "facebook_mobile"
    
    static let AccessToken = "access_token"
   
    }
    
    struct UrlKeys {
        
        static let UserID = "id"
        
        
    }

    
    struct ParameterKeys {
   
    static let ParseApiKey = "X-Parse-REST-API-Key"

    static let ParseApplicationID = "X-Parse-Application-Id"
        
    static let Limit = "limit"
    }
 
    struct JsonResponseKeys {
    
    // MARK: General
    static let StatusMessage = "status_message"
    static let StatusCode = "status_code"
        
    // Mark : Authorization
    
    static let Key = "key"
        
    static let Session = "session"
        
    static let Account = "account"
        
    static let Registered = "registered"
    
    static let Error = "error"
    // Mark : Account
    
    static let ID = "id"
        
    // Mark : Student Location
        
    static let ObjectID = "objectId"
        
    static let UniqueKey = "uniqueKey"
        
    static let FirstName = "firstName"
        
    static let LastName = "lastName"
        
    static let Latitude = "latitude"
        
    static let Longitude = "longitude"
        
    static let MediaURL = "mediaURL"
        
    static let Results = "results"
        
    // Mark : User
    
    static let UserFirstName =  "first_name"
        
    static let UserLastName  = "last_name"
        
    static let User = "user"
    }
    
}