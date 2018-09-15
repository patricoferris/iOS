//
//  ViewController.swift
//  Pacer
//
//  Created by Patrick Ferris on 14/09/2018.
//  Copyright © 2018 Patrick Ferris. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var imperialLabel: UILabel!
    @IBOutlet weak var metricLabel: UILabel!
    @IBOutlet weak var kmOrMiles: UISegmentedControl!
    
    var metric: Bool!
    
    let pickerData = [
        Array(0...15),
        Array(0...59)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
        metric = kmOrMiles.selectedSegmentIndex == 0 ? true : false
        self.logo.image = UIImage(named: "pacerLogo")
        updatePaces()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeMeasurement(_ sender: UISegmentedControl) {
        metric = sender.selectedSegmentIndex == 0 ? true : false
        updatePaces()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[component][row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updatePaces()
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = component == 1 && row < 10 ? "0\(String(pickerData[component][row]))" : String(pickerData[component][row])
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 15.0)!])
        return myTitle
    }
    
    func updatePaces() {
        let pace = Pace(minutes: Double(picker.selectedRow(inComponent: 0)), seconds: Double(picker.selectedRow(inComponent: 1)), metric: metric)
        
        let milePace = pace.getPacePerMile()
        let kmPace = pace.getPacePerKm()
        
        
        imperialLabel.text = milePace[1] < 10 ? "\(milePace[0]):0\(milePace[1]) min/mile" : "\(milePace[0]):\(milePace[1]) min/mile"
        metricLabel.text = kmPace[1] < 10 ? "\(kmPace[0]):0\(kmPace[1]) min/km" : "\(kmPace[0]):\(kmPace[1]) min/km"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }


}

