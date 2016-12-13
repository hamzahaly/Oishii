//
//  MapViewController.swift
//  Oishii
//
//  Created by iGuest on 12/13/16.
//  Copyright © 2016 Bentai. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: UIView!
    
    var map: GMSMapView!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 13.0
    var firstUpdateDone: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        super.loadView()
        let camera = GMSCameraPosition.camera(withLatitude: 47, longitude: -122, zoom: 10.0)
        map = GMSMapView.map(withFrame: mapView.bounds, camera: camera)
        map.isMyLocationEnabled = true
        map.settings.myLocationButton = true
        mapView.addSubview(map)
    }
    
    func updateMarkers() {
        map.clear()
        placesClient.currentPlace(callback: { (placeLikelihoods, error) -> Void in
            if let error = error {
                print("Current Place error: \(error.localizedDescription)")
                return
            }
            
            if let likelihoodList = placeLikelihoods {
                let latitude = likelihoodList.likelihoods[0].place.coordinate.latitude
                let longitude = likelihoodList.likelihoods[0].place.coordinate.longitude
                let urlstring = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitude),\(longitude)&radius=10000&keyword=asian&type=grocery_or_supermarket&key=AIzaSyCk_aZSvY9AeVxHgTe9oeCYYYXgLZ3S78g"
                let url = NSURL(string: urlstring)
                let session = URLSession.shared
                if url != nil {
                    let task = session.dataTask(with: url as! URL, completionHandler: {urlData, response, error in
                        print("boo")
                        if urlData != nil && error == nil{
                            do {
                                let jsonresult = try JSONSerialization.jsonObject(with: urlData!, options: []) as! [String: Any]
                                let results = jsonresult["results"] as! [[String:Any]]
                                print(results.count)
                                for result in results {
                                    var geometry = result["geometry"] as! [String:Any]
                                    var resultloc = geometry["location"] as! [String:Double]
                                    let name = result["name"] as! String
                                    let address = result["vicinity"] as! String
                                    
                                    let marker = GMSMarker()
                                    marker.position = CLLocationCoordinate2D(latitude: resultloc["lat"]!, longitude: resultloc["lng"]!)
                                    marker.title = name
                                    marker.snippet = address
                                    marker.map = self.map
                                }
                            } catch {
                                print(error)
                            }
                        } else {
                            let alert = UIAlertController(title: "Error", message: "Could not connect to Google Maps", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    })
                    task.resume()
                }

            }
        })
    }
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        currentLocation = location
        
        if(!firstUpdateDone){
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                  longitude: location.coordinate.longitude,
                                                  zoom: zoomLevel)
            
            if map.isHidden {
                map.isHidden = false
                map.camera = camera
            } else {
                map.animate(to: camera)
            }
            
            firstUpdateDone = true
        }
        
        updateMarkers()
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
