//
//  Capital.swift
//  CapitalCities
//
//  Created by David Petrofsky on 11/12/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D,
         info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
