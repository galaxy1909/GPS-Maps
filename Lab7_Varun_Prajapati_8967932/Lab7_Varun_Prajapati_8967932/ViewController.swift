//
//  ViewController.swift
//  Lab7_Varun_Prajapati_8967932
//
//  Created by user237779 on 3/15/24.
//

import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var previousLocation: CLLocation!
    
    var maxAcc : Double = 0
    var locationStartTime = Int64(Date().timeIntervalSince1970 * 1000)
    var counter:Double = 0
    
    var totalSpeed: CLLocationSpeed = 0
    
    @IBOutlet weak var currentSpeed: UILabel!
    
    @IBOutlet weak var maxSpeed: UILabel!
    
    @IBOutlet weak var avgSpeed: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    
    @IBOutlet weak var maxAcceleration: UILabel!
    
    @IBOutlet weak var speedAlert: UILabel!
    
    @IBOutlet weak var userLocationMap: MKMapView!
    
    @IBOutlet weak var tripAlert: UILabel!
    
    var currentSpeedOfUser: CLLocationSpeed = 0
    
    var maxSpeedOfUser: CLLocationSpeed = 0
    
    var averageSpeedOfUser: CLLocationSpeed = 0
    
    var distanceTravelled: CLLocationDistance = 0
    
   
    
    @IBAction func startTrip(_ sender: UIButton) {
        resetEveryVariable()
        locationManager.startUpdatingLocation()
        tripAlert.backgroundColor = UIColor.green
    }
    
    @IBAction func endTrip(_ sender: UIButton) {
        locationManager.stopUpdatingLocation()
      
        tripAlert.backgroundColor = UIColor.gray
    }
    
    
    
    func userTripData(_ location:CLLocation){
        
        let currentTime = Int64(Date().timeIntervalSince1970 * 1000)
        
        currentSpeedOfUser = location.speed
        
        //Here In lab assignment says distance before driver reaches to 115 km/h so I have make it for that reason.
        
        if((currentSpeedOfUser * 3.6) >= 115){
            speedAlert.backgroundColor = UIColor.red
        }
        
        else{
            speedAlert.backgroundColor = UIColor.lightGray
            distanceTravelled = distanceTravelled + location.distance(from:previousLocation)

        }
        
              

        totalSpeed = totalSpeed + currentSpeedOfUser
        
        counter = counter + 1
        
        averageSpeedOfUser = totalSpeed / counter
        
        if(maxSpeedOfUser < currentSpeedOfUser){
            maxSpeedOfUser = currentSpeedOfUser
        }
        
        // According to the definition s=d/t , so t=d/s. Also a=s/t ,substituting value of t as d/s , hence a=s/(d/s) that goes to a= s^2/d.
        
        let acceleration = (2 * distanceTravelled)  / Double(currentTime - locationStartTime)
        
        if(maxAcc < acceleration ){
            maxAcc = acceleration
        }
        
       
        //Here Speed is in m/s.So to convert it in km/h we need to multiply it to 3.6 because 1 m/s = 3.6 km/h
        
        
        currentSpeed.text = String(format: "%2f   km/h", currentSpeedOfUser * 3.6)
        avgSpeed.text = String(format: "%2f   km/h", averageSpeedOfUser * 3.6)
        distance.text = String(format: "%2f   km", distanceTravelled/1000)
        maxAcceleration.text = String(format: "%2f   m/s^2", maxAcc)
        maxSpeed.text = String(format: "%2f   km/h", maxSpeedOfUser * 3.6)
        
     
        
        previousLocation = location
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

           if let location = locations.first {
               
               manager.startUpdatingLocation()
               
               render(location)
                        

           }
        guard let currentLocation = manager.location
        else{
            return
        }
        userTripData(currentLocation)

       }
    func render (_ location: CLLocation) {

        let coordinate = CLLocationCoordinate2D (latitude: location.coordinate.latitude, longitude: location.coordinate.longitude )

        //span settings determine how much to zoom into the map - defined details

        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)

        let region = MKCoordinateRegion(center: coordinate, span: span)

        userLocationMap.setRegion(region, animated: true)
        self.userLocationMap.showsUserLocation = true
        

    }

    private func resetEveryVariable(){
        currentSpeedOfUser = 0
        
        maxSpeedOfUser = 0
        
        averageSpeedOfUser = 0
        
        distanceTravelled = 0
        
        maxAcc  = 0
        
        counter = 0

        totalSpeed = 0
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        previousLocation = locationManager.location ?? CLLocation()
        locationManager.requestWhenInUseAuthorization()
        resetEveryVariable()
        currentSpeed.text = "00.00 km/h"
        maxSpeed.text = "00.00 km/h"
        avgSpeed.text = "00.00 km/h"
        distance.text = "00.00 km"
        maxAcceleration.text = "00.00 m/s"
        // Do any additional setup after loading the view.
    }


    
}

