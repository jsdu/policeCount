//
//  ViewController.swift
//  realPrices
//
//  Created by Jason Du on 2016-01-04.
//  Copyright © 2016 Jason Du. All rights reserved.
//

import UIKit
import Foundation
import MapKit
import CoreData

class mapController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var loading: UIActivityIndicatorView!
    
    var searchController: UISearchController?
    
    var markerArr: [FBAnnotation] = []
    
    var clusteringManager:FBClusteringManager!
    var addressArr = [String]()
    
    var startingCoord: CLLocationCoordinate2D = CLLocationCoordinate2DMake(43.6518927, -79.381713)
    
    var didTurnOff: Bool = true
    

    var currentMarker:FBAnnotationView?
    var coordinates:CLLocationCoordinate2D = CLLocationCoordinate2DMake(0.0, 0.0)

    
    override func viewDidAppear(animated: Bool) {
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        mapView.rotateEnabled = false
        mapView.pitchEnabled = false
        
        
        clusteringManager = FBClusteringManager()
//        clusteringManager.addAnnotations(randomLocationsWithCount(1000))

        clusteringManager!.delegate = self
        
        self.mapView.showsPointsOfInterest = false
        
        for items in pdata.sharedInstance.newData{
            if (items.address != "") {
                let newMarker = FBAnnotation()
                newMarker.year = items.year
                newMarker.month = items.month
                newMarker.day = items.day
                newMarker.state = items.state
                newMarker.cause = items.cause
                newMarker.age = items.age
                newMarker.sex = items.sex
                newMarker.name = items.name
                newMarker.race = items.race
                newMarker.address = items.address
                addressArr.append(newMarker.address)
            }
        }
        nextGeocodeRequest()
        
        
        self.clusteringManager.addAnnotations(self.markerArr)
        NSOperationQueue().addOperationWithBlock({
            let mapBoundsWidth = Double(self.mapView.bounds.size.width)
            
            let mapRectWidth:Double = self.mapView.visibleMapRect.size.width
            
            let scale:Double = mapBoundsWidth / mapRectWidth
            
            let annotationArray = self.clusteringManager.clusteredAnnotationsWithinMapRect(self.mapView.visibleMapRect, withZoomScale:scale)
            
            self.clusteringManager.displayAnnotations(annotationArray, onMapView:self.mapView)
            
        })
        
    }
    
    func nextGeocodeRequest()->Void {
//        print(self.addressArr.count)
        if (self.addressArr.count == 0){
            return
        }
        
        let nextAddress = addressArr[0]
        print(nextAddress)
        addressArr.removeAtIndex(0)
        let geocoder = CLGeocoder()

        geocoder.geocodeAddressString(nextAddress, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
//                print("Error", error)
            } else if let placemark = placemarks?.first {
//                print(nextAddress)
                self.coordinates = placemark.location!.coordinate
//                print(self.coordinates)
            }
            self.nextGeocodeRequest()
        })
        
    }

    
//        func randomLocationsWithCount(count:Int) -> [FBAnnotation] {
//            var array:[FBAnnotation] = []
//            for _ in 0...count {
//                let a:FBAnnotation = FBAnnotation()
//                a.coordinate = CLLocationCoordinate2D(latitude: drand48() * 40 - 20, longitude: drand48() * 80 - 40 )
//                a.title = "Title"
//                a.soldPrice = Double(Int(arc4random_uniform(12)))*100000.0
//                a.askPrice = Double(Int(arc4random_uniform(12)))*100000.0
//                a.soldDate = "2016-01-03"
//                a.bed = Int(arc4random_uniform(6))
//                a.bath = Int(arc4random_uniform(6))
//                a.address = "22 Applegate Cres."
//                a.homeType = "detached"
//                a.houseStyle = "twnhouse"
//                a.mlsno = "\(arc4random_uniform(20)*arc4random_uniform(20)*arc4random_uniform(20))"
//                array.append(a)
//                //markerArr.append(a)
//            }
//            return array
//        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewWillDisappear(animated:Bool){
        super.viewWillDisappear(animated)
    }
    
}

extension mapController : FBClusteringManagerDelegate {
    
    func cellSizeFactorForCoordinator(coordinator:FBClusteringManager) -> CGFloat{
        return 1.0
    }
    
}


extension mapController : MKMapViewDelegate {
    

    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool){

        NSOperationQueue().addOperationWithBlock({
            let mapBoundsWidth = Double(self.mapView.bounds.size.width)
            
            let mapRectWidth:Double = self.mapView.visibleMapRect.size.width
            
            let scale:Double = mapBoundsWidth / mapRectWidth
            
            let annotationArray = self.clusteringManager.clusteredAnnotationsWithinMapRect(self.mapView.visibleMapRect, withZoomScale:scale)
            
            self.clusteringManager.displayAnnotations(annotationArray, onMapView:self.mapView)
        })
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        var reuseId = ""
        if annotation.isKindOfClass(FBAnnotationCluster) {
            
            reuseId = "Cluster"
            var clusterView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            clusterView = FBAnnotationClusterView(annotation: annotation, reuseIdentifier: reuseId)
            
            return clusterView
            
        } else {
            
            reuseId = "Pin"
            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            pinView = FBAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = false
            
            return pinView
        }
    }
    
}
