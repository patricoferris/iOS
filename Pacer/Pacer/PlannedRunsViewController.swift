//
//  PlannedRunsViewController.swift
//  Pacer
//
//  Created by Patrick Ferris on 15/09/2018.
//  Copyright © 2018 Patrick Ferris. All rights reserved.
//

import UIKit
import Foundation

class PlannedRunsViewController: UIViewController, BlockAdder {
    
    var metric: Bool!
    var trainingBlock: TrainingBlock!
    var tableViewController : PlannedRunsController!
    var blockController : BlockCreator!
    
    @IBOutlet weak var metricButton: UISegmentedControl!
    @IBOutlet weak var table: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trainingBlock = TrainingBlock(metric: metricButton.selectedSegmentIndex == 0 ? true : false)
        metric = metricButton.selectedSegmentIndex == 0 ? true : false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let viewController1 as PlannedRunsController:
            self.tableViewController = viewController1
        default:
            break
        }
        
        if let addBlock = segue.destination as? BlockCreator {
            addBlock.delegate = self
        }
        
    }
    
    @IBAction func switchMetric(_ sender: UISegmentedControl) {
        trainingBlock.setMetric(metricButton.selectedSegmentIndex == 0 ? true : false)
        metric = metricButton.selectedSegmentIndex == 0 ? true : false
    }
    
    func addBlock() {
        trainingBlock.setMetric(self.metric)
        tableViewController.addBlock(trainingBlock)
    }
}

class BlockCreator : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var metric : Bool!
    var trainingBlock : TrainingBlock!
    var delegate: BlockAdder!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var time: UIPickerView!
    @IBOutlet weak var distanceLabel: UILabel!
    
    let pickerData = [
        Array(0...24),
        Array(0...59),
        Array(0...59)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        time.dataSource = self
        time.delegate = self
        self.trainingBlock = TrainingBlock(metric: true)
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        setTime()
    }
    
    func setTime() {
        let hours = time.selectedRow(inComponent: 0)
        let minutes = time.selectedRow(inComponent: 1)
        let seconds = time.selectedRow(inComponent: 2)
        trainingBlock.setGoalTime([Double(hours), Double(minutes), Double(seconds)])
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        trainingBlock.setDate(sender.date)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        distanceLabel.text = String(sender.value)
        trainingBlock.setDistance(Double(sender.value))
    }
    
    
    @IBAction func createBlock(_ sender: UIBarButtonItem) {
        delegate?.trainingBlock = trainingBlock
        print(delegate?.trainingBlock)
        delegate?.addBlock()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
       self.dismiss(animated: true, completion: nil)
    }
    
}

protocol BlockAdder {
    
    var metric : Bool! {get set}
    var trainingBlock : TrainingBlock! {get set}
    var tableViewController : PlannedRunsController! {get set}
    
    func addBlock()
    
}






























