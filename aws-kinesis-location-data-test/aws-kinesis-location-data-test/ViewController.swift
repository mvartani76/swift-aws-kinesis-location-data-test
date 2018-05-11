//
//  ViewController.swift
//  aws-kinesis-location-data-test
//
//  Created by Michael Vartanian on 4/26/18.
//  Copyright © 2018 Michael Vartanian. All rights reserved.
//

import UIKit
import CoreLocation
import AWSKinesis

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    @IBOutlet weak var dataCountLabel: UILabel!
    
    var locationManager:CLLocationManager!
    var dataCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        determineMyCurrentLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.distanceFilter = LocationManagerDistanceFilter
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        let fireHoseRecorder = AWSFirehoseRecorder.default()
        
        let now = Date()
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString = formatter.string(from: now)
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")

        latLabel.text = userLocation.coordinate.latitude.description
        lonLabel.text = userLocation.coordinate.longitude.description
        dataCountLabel.text = dataCount.description
        
        // Save the kinesis firehose records locally
        fireHoseRecorder.saveRecord(dateString.data(using: String.Encoding.utf8), streamName: MyStreamName)
        fireHoseRecorder.saveRecord(",".data(using: String.Encoding.utf8), streamName: MyStreamName)
        fireHoseRecorder.saveRecord(latLabel.text?.data(using: String.Encoding.utf8), streamName: MyStreamName)
        fireHoseRecorder.saveRecord(",".data(using: String.Encoding.utf8), streamName: MyStreamName)
        fireHoseRecorder.saveRecord(lonLabel.text?.data(using: String.Encoding.utf8), streamName: MyStreamName)
        fireHoseRecorder.saveRecord("\n".data(using: String.Encoding.utf8), streamName: MyStreamName)
        
        dataCount = dataCount + 1
        
        // Submit all records after DataCountThreshold times collecting data
        if dataCount > DataCountThreshold {
            fireHoseRecorder.submitAllRecords()
            dataCount = 0
        }
    }
}
