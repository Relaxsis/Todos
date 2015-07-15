//
//  Todo.swift
//  Todos
//
//  Created by Admin on 11.07.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import Foundation
import Alamofire

final class Todo : ResponseObjectSerializable, ResponseCollectionSerializable {
    let id : Int
    let project_id:Int
    let dotext:String
    var isComplete:Bool
    
    @objc required init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.id = representation.valueForKeyPath("id") as! Int
        self.project_id = representation.valueForKeyPath("project_id") as! Int
        self.dotext = representation.valueForKeyPath("dotext") as! String
        self.isComplete = representation.valueForKeyPath("isComplete") as! Bool
    }
    
    @objc class func collection(#response: NSHTTPURLResponse, representation: AnyObject) -> [Todo] {
        var todos: [Todo] = []
        
        if let representation = representation as? [[String: AnyObject]] {
            for todoRepresentation in representation {
                if let todo = Todo(response: response, representation: todoRepresentation){
                    todos.append(todo)
                }
            }
        }
        return todos
    }
}