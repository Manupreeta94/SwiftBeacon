//
//  ViewController.swift
//  TrialBeacondetect
//
//  Created by Maheshwar Reddy on 13/03/20.
//  Copyright © 2020 Maheshwar Reddy. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation

class ViewController: UIViewController, CBPeripheralManagerDelegate, CLLocationManagerDelegate
{
//
    
    @IBOutlet weak var uuidValue: UILabel!
    @IBOutlet weak var majorValue: UILabel!
    @IBOutlet weak var minorValue: UILabel!
    @IBOutlet weak var identityValue: UILabel!
    @IBOutlet weak var beaconStatus: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    let identifier = "com.apple.beacon"
    //let uuid = NSUUID(uuidString: "F34A1A1F-500F-48FB-AFAA-9584D641D7B1")
     
   var beaconRegion: CLBeaconRegion!
    var localBeacon: CLBeaconRegion!
    
    var locationManager: CLLocationManager!
    
    var isSearchingForBeacons = false
    
    var lastFoundBeacon:CLBeacon! = CLBeacon()
    
    var lastProximity:CLProximity! = CLProximity.unknown
     
    var bluetoothPeripheralManager: CBPeripheralManager!
     
    var isBroadcasting = false
    
    
    var beaconPeripheralData: NSDictionary!
    var peripheralManager: CBPeripheralManager!
//    let localBeaconUUID = UUID(uuidString: "F34A1A1F-500F-48FB-AFAA-9584D641D7B1")
    let localBeaconUUID = "F651C4C7-B4BC-4656-B246-AF8B709EF297"
    let localBeaconMajor: CLBeaconMajorValue = 123
    let localBeaconMinor: CLBeaconMinorValue = 456
//    let identifier = “Put your identifier here”
     
    var dataDictionary = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        beaconRegion=CLBeaconRegion(proximityUUID: uuid, major: localBeaconMajor, minor: localBeaconMinor)
       locationManager = CLLocationManager()
       locationManager.delegate = self
       locationManager.requestAlwaysAuthorization()
        
        stopButton.isHidden = true
        uuidValue.text = localBeaconUUID
        majorValue.text = String(localBeaconMajor)
        minorValue.text = String(localBeaconMinor)
        beaconStatus.text = "OFF"
        identityValue.text = identifier
        // Do any additional setup after loading the view.
    }
    
    func initLocalBeacon() {
    if localBeacon != nil {
    stopLocalBeacon()
    }
    let uuid = UUID(uuidString: localBeaconUUID)!
        beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: localBeaconMajor, minor: localBeaconMinor, identifier:"com.apple.beacon")
    beaconPeripheralData = localBeacon.peripheralData(withMeasuredPower: nil)
    peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
    }
    func stopLocalBeacon() {
    peripheralManager.stopAdvertising()
    peripheralManager = nil
    beaconPeripheralData = nil
    localBeacon = nil
    }
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
    if peripheral.state == .poweredOn {
    peripheralManager.startAdvertising(beaconPeripheralData as? [String: Any])
    }
    else if peripheral.state == .poweredOff {
    peripheralManager.stopAdvertising()
    }
    }
    
    // MARK: Action
    @IBAction func startButton(_ sender: Any) {
    initLocalBeacon()
    startButton.isHidden = true
    stopButton.isHidden = false
    beaconStatus.text = "ON"
    }
    @IBAction func stopButton(_ sender: Any) {
    stopLocalBeacon()
    startButton.isHidden = false
    stopButton.isHidden = true
    beaconStatus.text = "OFF"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//    if status == .authorizedAlways {
//        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
//            if CLLocationManager.isRangingAvailable() {
//                startScanning()
//            }
//        }
//    }
//
//    func startScanning() {
//        let uuid = UUID(uuidString: "F34A1A1F-500F-48FB-AFAA-9584D641D7B1")!
//        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")
//
//        locationManager.startMonitoring(for: beaconRegion)
//        locationManager.startRangingBeacons(in: beaconRegion)
//    }




