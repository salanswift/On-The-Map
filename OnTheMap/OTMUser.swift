//
//  User.swift
//  On The Map
//
//  Created by Arsalan Akhtar on 06/07/2015.
//  Copyright (c) 2015 Arsalan Akhtar. All rights reserved.
//

import Foundation

struct OTMUser {
    
    var firstName = ""
    var lastName = ""
    var uniqueKey  = ""
   
    
    /* Construct a OTMUser from a dictionary */
    init(dictionary: [String : AnyObject]) {
    
        firstName = dictionary[OTMClient.JsonResponseKeys.FirstName] as! String
        lastName = dictionary[OTMClient.JsonResponseKeys.LastName] as! String
        uniqueKey = dictionary[OTMClient.JsonResponseKeys.Key] as! String
      
        
    }
}
