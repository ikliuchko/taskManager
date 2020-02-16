//
//  EditTaskViewController.swift
//  Managing tasks
//
//  Created by JBS Solutions on 16.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit

class EditTaskViewController: UIViewController, StoryboardLoadable {
    
    // MARK: - Constants
    
    private struct Constants {
        static let priorities: [TaskPriority] = [TaskPriority.low,
                                                 TaskPriority.normal,
                                                 TaskPriority.high]
        static let titleLabelTitle = "Title"
        static let prioLabelTitle = "Priority"
        static let descriptionLabelTitle = "Description"
        static let dueToLabelTitle = "Due to"
        static let notificationLabelTitle = "Notify"
        static let notImplementedStaff = "42"
    }
    
    static let storyboardName: StoryboardName = .editTask
    
    // MARK: - Properties
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var titleTextView: UITextView!
    @IBOutlet private var dueDateTitleLabel: UILabel!
    @IBOutlet private var dueDateTextField: UITextField!
    @IBOutlet private var priorityTitleLabel: UILabel!
    @IBOutlet private var prioritySelector: UISegmentedControl!
    @IBOutlet private var descritptionTitleLabel: UILabel!
    @IBOutlet private var descriptionTextView: UITextView!
    @IBOutlet private var notificationTitleLabel: UILabel!
    @IBOutlet private var notificationLabel: UILabel!
    @IBOutlet private var saveTaskButton: AmazingButton!
    
    private var taskDetails: TaskDetails?
    
    private let taskService = TaskService()
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        titleTextView.delegate = self
        descriptionTextView.delegate = self
        dueDateTextField.delegate = self
        setDoneOnKeyboardForTextView(for: descriptionTextView)
        setDoneOnKeyboardForTextView(for: titleTextView)
    }
    
    // MARK: - Lifecycle
    
    // MARK: - Public
    
    func update(with task: TaskDetails) {
        self.taskDetails = task
    }
    
    // MARK: - Private
    
    private func setupUI() {
        hideKeyboardWhenTappedAround()
        
        titleLabel.text = Constants.titleLabelTitle
        titleTextView.text = taskDetails?.title ?? ""
        dueDateTitleLabel.text = Constants.dueToLabelTitle
        
        if let dueDate = taskDetails?.dueDate {
            let timeInterval = Double(dueDate)
            setDueDateToTextField(Date(timeIntervalSince1970: timeInterval))
        } else {
            setDueDateToTextField(Date())
        }
        
        priorityTitleLabel.text = Constants.prioLabelTitle
        descritptionTitleLabel.text = Constants.descriptionLabelTitle
        descriptionTextView.text = taskDetails?.title ?? ""
        // wha
        notificationTitleLabel.text = Constants.notificationLabelTitle
        notificationLabel.text = Constants.notImplementedStaff
        saveTaskButton.set(type: .saveTask)
        
        if let prio = taskDetails?.priority {
            prioritySelector.selectedSegmentIndex = Constants.priorities.firstIndex(of: prio) ?? 0
        } else {
            prioritySelector.selectedSegmentIndex = 0
        }
    }
    
    private func saveTask(task: TaskDetails) {
        guard let editedTask = taskDetails,
            let taskId = editedTask.id else {
                taskService.addNewTask(task: task)
                    .done { [weak self] in
                        self?.navigationController?.popViewController(animated: true)
                }
                .catch { [weak self] error in
                    self?.presentDefaultErrorAlert(error: error)
                }
                return
        }
        
        taskService.updateTask(withId: taskId, with: task)
            .done { [weak self] in
                guard let tasksVC = self?.navigationController?.viewControllers.first(where: { $0 is TasksViewController} ) else { return }
                self?.navigationController?.popToViewController(tasksVC, animated: true)
        }
        .catch { [weak self] error in
            self?.presentDefaultErrorAlert(error: error)
        }
    }
    
    private func setDoneOnKeyboardForTextView(for textView: UITextView) {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: self,
                                            action: #selector(dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        textView.inputAccessoryView = keyboardToolbar
    }
    
    @objc func setupDueDatePickerView() {
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = .date
        datePickerView.backgroundColor = .white
        datePickerView.minimumDate = Date()
        
        if let dateFromField = getDueDateFromTextField() {
            datePickerView.date = dateFromField
        }
        dueDateTextField.inputView = datePickerView
        dueDateTextField.inputAccessoryView = getToolbarForHelperView(withCloseAction: #selector(doneDueDatePicker))
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    
    private func setDueDateToTextField(_ date: Date?) {
        var dateStrToSet: String = ""
        
        defer {
            dueDateTextField.text = dateStrToSet
        }
        
        guard let date = date else {
            return
        }
        
        let dateFormatter = DateFormatter().dateFormatterForDueDate()
        dateStrToSet = dateFormatter.string(from: date)
    }
    
    private func getDueDateFromTextField() -> Date? {
        var dateForReturn: Date?
        let dateFormatter = DateFormatter().dateFormatterForDueDate()
        dateForReturn = dateFormatter.date(from: dueDateTextField.text ?? "")
        return dateForReturn
    }
    
    private func getToolbarForHelperView(withCloseAction action: Selector?) -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Next",
                                         style: .plain,
                                         target: self,
                                         action: action)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                          target: nil,
                                          action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    private func getDueDateInt() -> Int {
        let dueDate = getDueDateFromTextField() ?? Date()
        return Int(dueDate.timeIntervalSince1970)
    }
    
    
    // MARK: - Actions
    
    @IBAction private func saveTask(_ sender: Any) {
        let taskPrio: TaskPriority = Constants.priorities[prioritySelector.selectedSegmentIndex]
        let newTask = TaskDetails(id: taskDetails?.id,
                                  title: titleTextView.text ?? "",
                                  dueDate: getDueDateInt(),
                                  priority: taskPrio)
        
        saveTask(task: newTask)
    }
    
    @objc private func handleDatePicker(sender: UIDatePicker) {
        setDueDateToTextField(sender.date)
    }
    
    @objc private func doneDueDatePicker() {
        donePicker(dueDateTextField)
    }
    
    @objc private func donePicker(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}

extension EditTaskViewController: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        dismissKeyboard()
        return true
    }
}

extension EditTaskViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dueDateTextField {
            setupDueDatePickerView()
        }
    }
}
