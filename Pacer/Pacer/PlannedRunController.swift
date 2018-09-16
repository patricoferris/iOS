//
//  PlannedRunController.swift
//  Pacer
//
//  Created by Patrick Ferris on 15/09/2018.
//  Copyright © 2018 Patrick Ferris. All rights reserved.
//

import UIKit
import Foundation

class TrainingBlockCell: UITableViewCell {
    
    @IBOutlet weak var dateAndType: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var goalPace: UILabel!
}

class PlannedRunsController: UITableViewController {
    
    let cellId = "TrainCell"
    var blocks : [TrainingBlock] = [TrainingBlock]()
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addBlock(_ block: TrainingBlock) {
        blocks.append(block)
        blocks.sort(by: { $0.date < $1.date })
        table.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blocks.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            blocks.remove(at: indexPath.row)
            table.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TrainingBlockCell
        let block = blocks[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        cell.dateAndType.text = "\(dateFormatter.string(from: block.date)) : \(block.type.toString())"
        cell.distance.text = block.metric ? "\(block.distance) km" : "\(block.distance) miles"
        
        let pace = Pace(distance: block.distance, minutes: block.goalTime[0], seconds: block.goalTime[1], metric: block.metric)
        let kmSec = pace.getPacePerKm()[1] < 10 ? "0\(pace.getPacePerKm()[1])" : "\(pace.getPacePerKm()[1])"
        let mileSec = pace.getPacePerMile()[1] < 10 ? "0\(pace.getPacePerMile()[1])" : "\(pace.getPacePerMile()[1])"
        
        cell.goalPace.text = block.metric ? "Avg: \(pace.getPacePerKm()[0]):\(kmSec) min/km" : "Avg: \(pace.getPacePerMile()[0]):\(mileSec) min/mile"
        
        return cell
    }
    
}
