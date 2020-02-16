//
//  TasksViewController.swift
//  Managing tasks
//
//  Created by JBSolutions on 11.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, StoryboardLoadable {
    
    // MARK: - Constants

    private struct Constants {
        static let sortImageName = "line.horizontal.3.decrease"
        static let addButtonCornerRadius: CGFloat = 30.0
        static let toolBarHeight: CGFloat = 30.0
        static let pickerViewHeight: CGFloat = 150.0
        static let pickerViewY: CGFloat = UIScreen.main.bounds.size.height - Constants.pickerViewHeight
    }
    
    private enum SortOptions: String, CaseIterable {
        case byTitle = "Sort by title"
        case byDate = "Sort by date"
        case byPriority = "Sort by priority"
    }
    
    static let storyboardName: StoryboardName = .tasks

    // MARK: - Properties
    
    private var taskDetails: [TaskDetails] = []
    
    @IBOutlet private var tasksTableView: UITableView!
    @IBOutlet private var addTaskButton: UIButton!
    
    private let refreshControl = UIRefreshControl()
    private let taskService = TaskService()
    
    private var toolBar: UIToolbar?
    private var picker: UIPickerView?
    

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationBar()
        setupButton()
        setupPickerView()
        setupToolbarForHelperView(withCloseAction: #selector(donePicker))
        getTasks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.setHidesBackButton(true, animated: false)
        
        getTasks()
    }

    // MARK: - Public

    // MARK: - Private
    
    private func setupTableView() {
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        let cellNib = UINib(nibName: TaskCell.nibName, bundle: nil)
        tasksTableView.register(cellNib, forCellReuseIdentifier: TaskCell.reuseIdentifier)
        
        tasksTableView.refreshControl = refreshControl
        refreshControl.tintColor = .darkGray
        refreshControl.addTarget(self, action: #selector(getTasks), for: .valueChanged)
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.sortImageName),
                                  style: .plain,
                                  target: self,
                                  action: #selector(sortTapped))

    }
    
    private func setupButton() {
        addTaskButton.layer.cornerRadius = Constants.addButtonCornerRadius
        addTaskButton.clipsToBounds = true
    }
    
    private func setupPickerView() {
        let picker = UIPickerView(frame: .zero)
        picker.backgroundColor = .white
        picker.delegate = self
        picker.dataSource = self
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0,
                                   y: Constants.pickerViewY,
                                   width: UIScreen.main.bounds.size.width,
                                   height: Constants.pickerViewHeight)
        self.picker = picker
    }
    
    private func setupToolbarForHelperView(withCloseAction action: Selector?) {
        let toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0,
                                                        y: Constants.pickerViewY,
                                                        width: UIScreen.main.bounds.size.width,
                                                        height: Constants.toolBarHeight))
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "OK",
                                         style: .plain,
                                         target: self,
                                         action: action)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                          target: nil,
                                          action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.toolBar = toolBar
    }
    
    @objc private func getTasks() {
        taskService.getCurrentTasks()
            .done { [weak self] tasks in
                self?.taskDetails = tasks
                self?.tasksTableView.reloadData()
        }
        .ensure { [weak self] in
            self?.refreshControl.endRefreshing()
        }
        .catch { [weak self] error in
            self?.presentDefaultErrorAlert(error: error)
        }
    }
    
    @objc private func sortTapped() {
        openPickerView()
    }
    
    private func openPickerView() {
        guard let pickerView = picker,
            let toolBarView = toolBar else { return }
        self.view.addSubview(pickerView)
        self.view.addSubview(toolBarView)
    }
    
    @objc private func donePicker() {
        toolBar?.removeFromSuperview()
        picker?.removeFromSuperview()
        applySort(by: picker?.selectedRow(inComponent: 0))
    }
    
    private func applySort(by index: Int?) {
        guard let index = index else { return }
        
        defer {
            tasksTableView.reloadData()
        }
        let sortOption = SortOptions.allCases[index]
        switch sortOption {
        case .byDate:
            taskDetails.sort { $0.dueDate < $1.dueDate }
        case .byPriority:
            taskDetails.sort { $0.priority.rawValue < $1.priority.rawValue }
        case .byTitle:
            taskDetails.sort { $0.title < $1.title }
        }
    }
    
    private func openTaskDetails(for details: TaskDetails) {
        let taskDetailsVC = TaskDetailsViewController.fromStoryboard()
        taskDetailsVC.update(with: details)
        navigationController?.pushViewController(taskDetailsVC, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction private func addNewTask(_ sender: Any) {
        let editTaskVC = EditTaskViewController.fromStoryboard()
        navigationController?.pushViewController(editTaskVC, animated: true)
    }

}


// MARK: - UITableViewDataSource
extension TasksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier) as? TaskCell else {
            return UITableViewCell()
        }
        cell.update(with: taskDetails[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TasksViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openTaskDetails(for: taskDetails[indexPath.row])
    }
    
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension TasksViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return SortOptions.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return SortOptions.allCases[row].rawValue
    }
}
