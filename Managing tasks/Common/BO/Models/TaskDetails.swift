//
//  TaskDetails.swift
//  Managing tasks
//
//  Created by JBSolutions on 12.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import Foundation

class TaskDetails {
    let id: Int?
    let title: String
    let dueDate: Int
    let priority: TaskPriority
    
    init(id: Int?, title: String, dueDate: Int, priority: TaskPriority) {
        self.id = id
        self.title = title
        self.dueDate = dueDate
        self.priority = priority
    }
    
    init?(id: Int?, title: String?, dueDate: Int?, priority: String?) {
        guard let id = id,
            let title = title,
            let dueDate = dueDate,
            let prio = priority,
            let taskPrio = TaskPriority(rawValue: prio) else {
                return nil
        }
        self.id = id
        self.title = title
        self.dueDate = dueDate
        self.priority = taskPrio
    }
}
