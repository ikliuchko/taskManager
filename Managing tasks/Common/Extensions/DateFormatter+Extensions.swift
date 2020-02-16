//
//  DateFormatter+Extensions.swift
//  Managing tasks
//
//  Created by JBS Solutions on 17.02.2020.
//  Copyright © 2020 JBSolutions. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    func dateFormatterForDueDate() -> DateFormatter {
        self.dateFormat = "dd MMMM yy"
        return self
    }
    
}
