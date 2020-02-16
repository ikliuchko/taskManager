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
    
    /// returns the list of created tasks
    func getCurrentTasks() -> Promise<[TaskDetails]> {
        return Promise { seal in
            DefaultAPI.tasksGet { (data, error) in
                if let error = error {
                    seal.reject(error)
                }
                if let data = data {
                    let tasks = data.tasks?.compactMap {
                        TaskDetails(id: $0._id, title: $0.title, dueDate: $0.dueBy, priority: $0.priority)
                    } ?? []
                    seal.fulfill(tasks)
                }
            }
        }
        
    }
    
    // creates a new task
    func addNewTask(task: TaskDetails) -> Promise<Void> {
        return Promise { seal in
            let body = Body(title: task.title,
                            dueBy: task.dueDate,
                            priority: Priority(rawValue: task.priority.rawValue))
            DefaultAPI.appHttpControllersAPITaskCreate(body: body) { (data, error) in
                if let error = error {
                    seal.reject(error)
                }
                if data != nil {
                    seal.fulfill(())
                }
            }
        }
    }
    
    // udpates the task by Id
    func updateTask(withId id: Int, with task: TaskDetails) -> Promise<Void> {
        return Promise { seal in
            let body = Body1(title: task.title,
                            dueBy: task.dueDate,
                            priority: Priority(rawValue: task.priority.rawValue))
            DefaultAPI.appHttpControllersAPITaskUpdate(task: id, body: body) { (data, error) in
                if let error = error {
                    seal.reject(error)
                }
                if data != nil {
                    seal.fulfill(())
                }
            }
        }
    }
    
    // deletes the task by id
    func deleteTask(withId id: Int) -> Promise<Void> {
        return Promise { seal in
            DefaultAPI.appHttpControllersAPITaskDelete(task: id) { (data, error) in
                if let error = error {
                    seal.reject(error)
                }
                if data != nil {
                   seal.fulfill(())
                }
            }
        }
    }
}
