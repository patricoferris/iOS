//
//  DistanceViewController.swift
//  Pacer
//
//  Created by Patrick Ferris on 23/09/2018.
//  Copyright © 2018 Patrick Ferris. All rights reserved.
//

import Foundation
import UIKit

class DistanceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var kmOrMile: UISegmentedControl!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var kmLabel: UILabel!
    @IBOutlet weak var mileLabel: UILabel!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var metric: Bool!
    
    let pickerData = [
        Array(0...24),
        Array(0...59),
        Array(0...59)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
        metric = kmOrMile.selectedSegmentIndex == 0 ? true : false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let titleData = (component == 1 || component == 2) && row < 10 ? "0\(String(pickerData[component][row]))" : String(pickerData[component][row])
        return titleData
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateLabels()
    }
    
    @IBAction func segmentSwitch(_ sender: UISegmentedControl) {
        metric = kmOrMile.selectedSegmentIndex == 0 ? true : false
        distanceLabel.text = metric ? "\(roundTo(distanceSlider.value)) km" : "\(roundTo(distanceSlider.value)) miles"
        updateLabels()
    }
    
    @IBAction func sliderUpdate(_ sender: UISlider) {
        distanceLabel.text = metric ? "\(roundTo(distanceSlider.value)) km" : "\(roundTo(distanceSlider.value)) miles"
        updateLabels()
    }
    
    func updateLabels() {
        let pace = Pace(distance: Double(roundTo(distanceSlider.value)), hours: Double(picker.selectedRow(inComponent: 0)), minutes: Double(picker.selectedRow(inComponent: 1)), seconds: Double(picker.selectedRow(inComponent: 2)), metric: metric)
        
        let milePace = pace.getPacePerMile()
        let kmPace = pace.getPacePerKm()
        
        
        mileLabel.text = milePace[1] < 10 ? "\(milePace[0]):0\(milePace[1]) min/mile" : "\(milePace[0]):\(milePace[1]) min/mile"
        kmLabel.text = kmPace[1] < 10 ? "\(kmPace[0]):0\(kmPace[1]) min/km" : "\(kmPace[0]):\(kmPace[1]) min/km"
    }
    
    func roundTo(_ x: Float) -> Double {
        return Double(Int((x * 10))) / 10.0
    }
    
    
}
