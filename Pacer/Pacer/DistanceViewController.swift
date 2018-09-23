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
        metric = kmOrMile.isSelected
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
    
    func updateLabels() {
        let pace = Pace(distance: Double(distanceSlider.value), hours: Double(picker.selectedRow(inComponent: 0)), minutes: Double(picker.selectedRow(inComponent: 1)), seconds: Double(picker.selectedRow(inComponent: 2)), metric: metric)
    }
    
    
}
