//
//  Location.swift
//  Weathers
//
//  Created by Chris Huang on 23/09/2016.
//  Copyright © 2016 Chris Huang. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    
    static var sharedInstance = Location()
    
    var latitude: Double?
    var longitude: Double?
}
