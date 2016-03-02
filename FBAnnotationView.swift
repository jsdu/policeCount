//
//  FBAnnotationView.swift
//  realPrices
//
//  Created by Jason Du on 2016-01-20.
//  Copyright © 2016 Jason Du. All rights reserved.
//

import UIKit
import MapKit

class FBAnnotationView: MKAnnotationView {

    var year = 2015
    var month = "January"
    var day = 1
    var state = "GA"
    var cause = "Death in Custody"
    var age = "30"
    var sex = "Male"
    var name = "Unknown"
    var race = "Unknown"
    var address = ""
    var latitude = 0.0
    var longitude = 0.0
    
    
    var fontSize:CGFloat = 11
    
    var imageName = "mapMarkerDetail"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?){
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        let annotation:FBAnnotation = annotation as! FBAnnotation
        
        year = annotation.year
        month = annotation.month
        day = annotation.day
        state = annotation.state
        cause = annotation.cause
        age = annotation.age
        sex = annotation.sex
        name = annotation.name
        race = annotation.race
        address = annotation.address
        latitude = annotation.coordinate.latitude
        longitude = annotation.coordinate.longitude
        backgroundColor = UIColor.clearColor()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    
    func roundToPlaces(value:Double, places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(value * divisor) / divisor
    }
    

}
