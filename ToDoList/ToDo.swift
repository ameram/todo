//
//  ToDo.swift
//  ToDoList
//
//  Created by Amirmohamad on 12/7/19.
//  Copyright © 2019 Antarctica. All rights reserved.
//

import Foundation

struct ToDo {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var note: String?
    
    static func loadTodos() -> [ToDo]? {
        return nil
    }
    
    static func loadSamples() -> [ToDo]?{
        let toDoOne = ToDo(title: "Buy 6 eggs", isComplete: false, dueDate: Date(), note: "Buy fresh ones.")
        let toDoTwo = ToDo(title: "Buy 3 Bananas", isComplete: false, dueDate: Date(), note: "Buy fresh ones.")
        let toDoThree = ToDo(title: "Write", isComplete: false, dueDate: Date(), note: "Diary.")
        
        return [toDoOne, toDoTwo, toDoThree]
        
    }
}
