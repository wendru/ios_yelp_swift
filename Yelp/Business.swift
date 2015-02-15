//
//  Business.swift
//  Yelp
//
//  Created by Andrew Wen on 2/12/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class Business: NSObject {
    var imageUrl:       String!
    var name:           String!
    var ratingImageUrl: String!
    var numReviews:     Int!
    var address:        String!
    var categories:     String!
    var distance:       Float!
    
    required init(dictionary: NSDictionary) {
        super.init()
        var cats = dictionary["categories"]?.objectAtIndex(0) as NSArray
        categories = cats.componentsJoinedByString(", ")
        
        imageUrl = dictionary["image_url"]? as NSString
        
        name = dictionary["name"]? as NSString
        
        var addr = (dictionary.valueForKeyPath("location.address")? as NSArray).componentsJoinedByString(", ")
        var neig = (dictionary.valueForKeyPath("location.neighborhoods")? as NSArray).componentsJoinedByString(", ")
        address = NSString(format: "%@, %@", addr, neig)
        
        numReviews = dictionary["review_count"]? as NSInteger
        
        ratingImageUrl = dictionary["rating_img_url"]? as NSString
        
//        distance = dictionary["distance"]? as Float * 0.000621371
    }
    
    class func businessesWithDictionaries(dictionaries: NSArray) -> NSArray {
        var businesses = NSMutableArray()
        
        for dictionary in dictionaries {
            var business = Business(dictionary: dictionary as NSDictionary)
            businesses.addObject(business)
        }
        
        return businesses
    }
}
