//
//  HomeViewController.swift
//  Demo
//
//  Created by ty on on 3/20/18.
//  Copyright © 2018 vanra. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
class HomeViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate,GMSAutocompleteViewControllerDelegate{

    var mapView : GMSMapView!
    let zoom : Float = 15.0
    var locationManager = CLLocationManager()
    var savedLocation : [location]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil{
        self.setupMenuGestureRecognizer()
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage.init(named: "menu"), style: .plain, target: self.revealViewController, action: #selector(self.revealViewController().revealToggle(_:))), animated: true)
        }
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage.init(named: "search"), style: .plain, target: self, action: #selector(searchLocation)), animated: true)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        setupGoogleMap()
    }
    
    
    //MARK: Search Location Action
    @objc func searchLocation(){
        print("zzz")
        let autoComplete = GMSAutocompleteViewController()
        autoComplete.delegate = self
        self.locationManager.startUpdatingLocation()
        present(autoComplete, animated: true, completion: nil)
        
    }
    
    //MARK: Setup Google Map View
    func setupGoogleMap(){
        loadSavedLocation()
        let camera = GMSCameraPosition.camera(withLatitude: 33.6407326, longitude: -84.4298888, zoom: self.zoom)
        self.mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.mapView.delegate = self
        self.mapView.isMyLocationEnabled = true
        self.mapView.settings.myLocationButton = true
        self.view.addSubview(self.mapView)
        addMapViewConstraint()
        addSavedMarker()
    }
    //MAR: Add Google Map Constraint
    func addMapViewConstraint(){
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        self.mapView.leading(to: self.view)
        self.mapView.top(to: self.view)
        self.mapView.width(to: self.view)
        self.mapView.height(to: self.view)
    }
    
    //MARK: Create marker for all saved location
    func addSavedMarker(){
        if self.savedLocation != nil{
            for i in 0 ..< savedLocation.count{
                let lat : Double = savedLocation[i].lat!
                let long  : Double = savedLocation[i].long!
               
                let tmpLocaiton = CLLocationCoordinate2D(latitude: (lat), longitude: long)
                let marker = GMSMarker(position: tmpLocaiton)
                marker.title = self.savedLocation[i].name
                marker.snippet = self.savedLocation[i].name
                marker.map = self.mapView
                print("hola")
            }
        }
    }
    
    
    //MARK: Load all save Location
    func loadSavedLocation(){
      
        if (LocationManager.shareInstance.getLocations()) != nil {
            self.savedLocation = LocationManager.shareInstance.getLocations()
            
        }
        else{
            self.savedLocation = dummyData
        }
          print(self.savedLocation.count)
       
    }
    
    
    
    
    //MARK: CLLoactionManager Delegate Method
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error loading map")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 10.0)
        self.mapView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        print(location?.coordinate)
    }
    
    
    
    //MARK: GMSMapView Delegate Method
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.mapView.isMyLocationEnabled = true
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        self.mapView.isMyLocationEnabled = true
        if(gesture){
           self.mapView.selectedMarker = nil
        }
    }

    
    
    //MARK: GMSAutoCompleteViewController Delegate Method
     func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16)
        let lastLocation = location.init(lattitude: Double(place.coordinate.latitude), longtitude: Double(place.coordinate.longitude), name: place.name)
        LocationManager.shareInstance.saveLocation(location: lastLocation)
        self.savedLocation.append(lastLocation)
        self.addSavedMarker()
        self.mapView.camera = camera
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error")
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        dismiss(animated: true, completion: nil)
    }
}





private let DimmingViewTag = 10001
//MARK: - SWRevealViewControllerDelegate
extension UIViewController: SWRevealViewControllerDelegate {
   
    func setupMenuGestureRecognizer() {
        
        revealViewController().delegate = self
        
        view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        view.addGestureRecognizer(revealViewController().tapGestureRecognizer())
    }
    
    //MARK: Bring another view to the front when show menu side bar
    public func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        

        if case .right = position {
            print("right")
            let dimmingView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height + 60))
            dimmingView.tag = DimmingViewTag
            dimmingView.backgroundColor = .clear
            dimmingView.alpha = 1.0
        
            
            
            view?.addSubview(dimmingView)
            view?.bringSubview(toFront: dimmingView)
//            UIView.animate(withDuration: 0.5) { () -> Void in
//                dimmingView.alpha = 0.3
//
//            }



        } else {
            UIView.animate(withDuration: 0.5) { () -> Void in
                self.navigationController?.navigationBar.layer.zPosition = 1
                self.view?.viewWithTag(DimmingViewTag)?.removeFromSuperview()

            }

        }
    }
}
