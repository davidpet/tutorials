//
//  Person.swift
//  NamesToFaces
//
//  Created by David Petrofsky on 10/24/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
