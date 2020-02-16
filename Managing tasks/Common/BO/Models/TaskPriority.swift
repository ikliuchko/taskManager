//
//  TaskPriority.swift
//  Managing tasks
//
//  Created by JBSolutions on 13.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import Foundation
import SwaggerClient

enum TaskPriority: String, Codable {
    case low = "Low"
    case normal = "Normal"
    case high = "High"
    
    init?(priority: Priority) {
        guard let taskPrio = TaskPriority(rawValue: priority.rawValue) else {
            return nil
        }
        self = taskPrio
    }
}
