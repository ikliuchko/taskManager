//
//  StoryboardLoadable.swift
//  Managing tasks
//
//  Created by JBSolutions on 11.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import UIKit

enum StoryboardName: String {
    case intro = "Intro"
    case signUp = "SignUp"
    case signIn = "SignIn"
    case tasks = "Tasks"
    case taskDetails = "TaskDetails"
    case editTask = "EditTask"
}

protocol StoryboardLoadable where Self: UIViewController {
    static var storyboardName: StoryboardName { get }
    static func fromStoryboard() -> Self
}

extension UIStoryboard {

    convenience init(_ name: StoryboardName) {
        self.init(name: name.rawValue, bundle: nil)
    }

    fileprivate func instantiate<T>(viewController: T.Type) -> T? {
        return instantiateViewController(withIdentifier: "\(T.self)") as? T
    }

}

extension StoryboardLoadable {

    static func fromStoryboard() -> Self {
        guard let controller = UIStoryboard(storyboardName).instantiate(viewController: Self.self) else {
            fatalError("Cannot instantiate \(Self.self) ViewController")
        }
        return controller
    }

}
