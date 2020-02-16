//
//  TaskCell.swift
//  Managing tasks
//
//  Created by JBSolutions on 11.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    // MARK: - Constants
    
    private struct Constants {
        
    }
    
    static let nibName = "TaskCell"
    static var reuseIdentifier: String { return String(describing: self) }
    
    // MARK: - Properties
    
    @IBOutlet private weak var taskTitleLabel: UILabel!
    @IBOutlet private weak var taskDateLabel: UILabel!
    @IBOutlet private weak var taskPrioLabel: UILabel!
    
    // MARK: - Overrides
    
    // MARK: - Lifecycle
    
    // MARK: - Public
    
    func update(with task: TaskDetails) {
        taskTitleLabel.text = task.title
        
        taskDateLabel.text = getStringDate(from: task.dueDate)
        taskPrioLabel.text = "Prio: \(task.priority.rawValue)"
    }
    
    // MARK: - Private
    private func getStringDate(from dueDate: Int) -> String {
        let timeInterval = Double(dueDate)
        let formatter = DateFormatter().dateFormatterForDueDate()
        return formatter.string(from: Date(timeIntervalSince1970: timeInterval))
    }
}
