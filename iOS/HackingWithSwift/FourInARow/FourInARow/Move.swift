//
//  Move.swift
//  FourInARow
//
//  Created by David Petrofsky on 11/19/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit
import GameplayKit

class Move: NSObject, GKGameModelUpdate {
    var value: Int = 0
    var column: Int
    
    init(column: Int) {
        self.column = column
    }
}
