//
//  Project.swift
//  Todos
//
//  Created by Admin on 11.07.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation
import Alamofire

final class Project :ResponseObjectSerializable, ResponseCollectionSerializable {
    let id: Int
    let projname: String
    var todos: [Todo]
    
    @objc required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.id = representation.valueForKeyPath("id") as! Int
        self.projname = representation.valueForKeyPath("projname") as! String
        self.todos = Todo.collection(response: response, representation: representation.valueForKeyPath("todos")!)
    }
    
    @objc static func collection(#response: NSHTTPURLResponse, representation: AnyObject) -> [Project] {
        var projects: [Project] = []
        
        if let representation = representation as? [[String: AnyObject]] {
            for projectRepresentation in representation {
                if let project = Project(response: response, representation: projectRepresentation){
                    projects.append(project)
                }
            }
        }
        return projects
    }
}
