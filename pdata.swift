//
//  pdata.swift
//  policeCount
//
//  Created by Jason Du on 2016-02-16.
//  Copyright © 2016 Jason Du. All rights reserved.
//

import UIKit

private let sharedInstance = pdata()

class pdata {
    static let sharedInstance = pdata()
    var newData:[policeData] = []
    var numState = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
    var numGender = [0.0,0.0]
    var numCause = [0.0,0.0,0.0,0.0]
    var numRace = [0.0,0.0,0.0,0.0,0.0,0.0,0.0]
    var numAge = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
    var young = 100
    var old = 0
    var average = 0.0
    class var sharedDispatchInstance: pdata {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: pdata? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = pdata()
        }
        return Static.instance!
    }
    
    class var sharedStructInstance: pdata {
        struct Static {
            static let instance = pdata()
        }
        return Static.instance
    }
}
