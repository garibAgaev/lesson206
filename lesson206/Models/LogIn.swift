//
//  LogIn.swift
//  lesson206
//
//  Created by Garib Agaev on 29.12.2022.
//

import Foundation

class User {
    
    var password: String
    var name: String
    var occupation: Occupation?
    
    private var startTime: CFAbsoluteTime
    private var startAge: Int?
    
    var age: Int? {
        guard let startAge = startAge else { return nil }
        return startAge + Int((CFAbsoluteTimeGetCurrent() - startTime)) / (60 * 60 * 24 * 365)
    }
    
    init(password: String, name: String, occupation: Occupation? = nil, age: Int? = nil) {
        self.password = password
        self.name = name
        self.occupation = occupation
        startAge = age
        startTime = CFAbsoluteTimeGetCurrent()
    }
    
    static func getUsers(logIn: String, password: String) -> [String: User]? {
        let access: [String: String] = ["User": "Password"]
        if access[logIn] == password {
            return [
                "User": User(password: "", name: "User"),
                "gad@swift.book": User(password: "Password", name: "GAD", occupation: .learner, age: 25),
                "eugenya@swift.book": User(password: "Password", name: "Eugenya", occupation: .teacher)
            ]
        }
        return nil
    }
}


enum Occupation: String {
    case teacher = "Teacher"
    case learner = "Learner"
}

