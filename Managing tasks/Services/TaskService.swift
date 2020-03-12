//
//  TaskService.swift
//  Managing tasks
//
//  Created by JBSolutions on 12.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import PromiseKit
import SwaggerClient

class TaskService {
    
    private let taskRepository = TaskRepository()
    
    /// returns the list of created tasks
    func getCurrentTasks() -> Promise<[TaskDetails]> {
        taskRepository.getCurrentTasks()
    }
    
    // creates a new task
    func addNewTask(task: TaskDetails) -> Promise<Void> {
        taskRepository.addNewTask(task: task)
    }
    
    // udpates the task by Id
    func updateTask(withId id: Int, with task: TaskDetails) -> Promise<Void> {
        taskRepository.updateTask(withId: id, with: task)
    }
    
    // deletes the task by id
    func deleteTask(withId id: Int) -> Promise<Void> {
        taskRepository.deleteTask(withId: id)
    }
}
