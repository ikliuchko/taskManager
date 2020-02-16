//
//  TaskDetailsViewController.swift
//  Managing tasks
//
//  Created by JBSolutions on 12.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit

class TaskDetailsViewController: UIViewController, StoryboardLoadable {
    
    // MARK: - Constants
    
    private struct Constants {
        static let editImageName = "pencil"
        static let prioLabelTitle = "Priority"
        static let descriptionLabelTitle = "Description"
        static let notificationLabelTitle = "Notify"
        static let notImplementedStaff = "42"
    }
    
    static let storyboardName: StoryboardName = .taskDetails
    
    // MARK: - Properties
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dueDateLabel: UILabel!
    @IBOutlet private var priorityTitleLabel: UILabel!
    @IBOutlet private var priorityLabel: UILabel!
    @IBOutlet private var descritptionTitleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var notificationTitleLabel: UILabel!
    @IBOutlet private var notificationLabel: UILabel!
    @IBOutlet private var deleteTaskButton: AmazingButton!
    
    private var taskDetails: TaskDetails?
    
    private let taskService = TaskService()
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationBar()
    }
    
    // MARK: - Public
    
    func update(with details: TaskDetails) {
        self.taskDetails = details
    }
    
    // MARK: - Private
    
    private func setupUI() {
        guard let taskDetails = taskDetails else { return }
        titleLabel.text = taskDetails.title
        dueDateLabel.text = getDueDateString(from: taskDetails.dueDate)
        priorityTitleLabel.text = Constants.prioLabelTitle
        priorityLabel.text = taskDetails.priority.rawValue
        descritptionTitleLabel.text = Constants.descriptionLabelTitle
        // wha
        descriptionLabel.text = taskDetails.title
        notificationTitleLabel.text = Constants.notificationLabelTitle
        notificationLabel.text = Constants.notImplementedStaff
        deleteTaskButton.set(type: .deleteTask)
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.editImageName),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(editButtonTapped))
        
    }
    
    private func getDueDateString(from dueDate: Int) -> String {
        let timeInterval = Double(dueDate)
        let formatter = DateFormatter().dateFormatterForDueDate()
        return formatter.string(from: Date(timeIntervalSince1970: timeInterval))
    }
    
    // MARK: - Actions
    
    @IBAction private func deleteTask(_ sender: Any) {
        guard let id = taskDetails?.id else {
            return
        }
        taskService.deleteTask(withId: id)
            .done { [weak self] in
                self?.navigationController?.popViewController(animated: true)
        }
        .catch { [weak self] error in
            self?.presentDefaultErrorAlert(error: error)
        }
    }
    
    @objc private func editButtonTapped() {
        guard let taskDetails = taskDetails else { return }
        let editTaskVC = EditTaskViewController.fromStoryboard()
        editTaskVC.update(with: taskDetails)
        navigationController?.pushViewController(editTaskVC, animated: true)
    }
}
