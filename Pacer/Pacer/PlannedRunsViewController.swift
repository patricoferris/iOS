//
//  PlannedRunsViewController.swift
//  Pacer
//
//  Created by Patrick Ferris on 15/09/2018.
//  Copyright © 2018 Patrick Ferris. All rights reserved.
//

import UIKit
import Foundation

class PlannedRunsViewController: UIViewController {
    
    var tableViewController : PlannedRunsController!
    var blockController : BlockCreator!
    
    @IBOutlet weak var metricButton: UISegmentedControl!
    @IBOutlet weak var table: UIView!
    
    var tableView : PlannedRunsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let viewController1 as PlannedRunsController:
            self.tableViewController = viewController1
        case let viewController2 as BlockCreator:
            self.blockController = viewController2
        default:
            break
        }
        
        self.blockController.metric = metricButton.selectedSegmentIndex == 0 ? true : false
    }

    @IBAction func addBlockPressed(_ sender: UIBarButtonItem) {
        tableViewController.addBlock(TrainingBlock(metric: true, distance: 10.0, goalTime: [40.0, 0.0], type: TrainingType.Uptempo, date: Date(timeIntervalSinceNow: 0)))
    }
    
    
}

class BlockCreator : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var metric : Bool!
    var trainingBlock : TrainingBlock!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var distanceAndTime: UIPickerView!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var distanceLabel: UILabel!
    
    let pickerData = [
        Array(0...24),
        Array(0...59),
        Array(0...59)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        distanceAndTime.dataSource = self
        distanceAndTime.delegate = self
        self.trainingBlock = TrainingBlock(metric: metric)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(pickerData[component][row])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        trainingBlock.setDate(sender.date)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        distanceLabel.text = String(sender.value)
        trainingBlock.setDistance(Double(sender.value))
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
       self.dismiss(animated: true, completion: nil)
    }
}






























