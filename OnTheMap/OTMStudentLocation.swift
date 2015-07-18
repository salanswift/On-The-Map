//
//  OTMStudentLocation.swift
//  On The Map
//
//  Created by Arsalan Akhtar on 01/07/2015.
//  Copyright (c) 2015 Arsalan Akhtar. All rights reserved.
//

import Foundation

struct OTMStudentLocation {
    
    var uniqueKey = ""
    var firstName = ""
    var lastName  = ""
    var mediaURL = ""
    var objectId = ""
    var latitude = 0.0
    var longitude = 0.0
    
    /* Construct a OTMStudentLocation from a dictionary */
    init(dictionary: [String : AnyObject]) {
        
        objectId = dictionary[OTMClient.JsonResponseKeys.ObjectID] as! String
        firstName = dictionary[OTMClient.JsonResponseKeys.FirstName] as! String
        lastName = dictionary[OTMClient.JsonResponseKeys.LastName] as! String
        mediaURL = dictionary[OTMClient.JsonResponseKeys.MediaURL] as! String
        uniqueKey = dictionary[OTMClient.JsonResponseKeys.UniqueKey] as! String
        latitude = dictionary[OTMClient.JsonResponseKeys.Latitude] as! Double
        latitude = dictionary[OTMClient.JsonResponseKeys.Longitude] as! Double
    
    }
    
    /* Helper: Given an array of dictionaries, convert them to an array of OTMStudentLocation objects */
    static func studentLocationsFromResults(results: [[String : AnyObject]]) -> [OTMStudentLocation] {
        var studentLocations = [OTMStudentLocation]()
        
        for result in results {
            studentLocations.append(OTMStudentLocation(dictionary: result))
        }
        
        return studentLocations
    }
}
