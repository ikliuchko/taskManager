//
// Body.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct Body: Codable {

    public var title: String?
    /** due date in the Unix timestamp (seconds) */
    public var dueBy: Int?
    public var priority: Priority?

    public init(title: String?, dueBy: Int?, priority: Priority?) {
        self.title = title
        self.dueBy = dueBy
        self.priority = priority
    }


}

