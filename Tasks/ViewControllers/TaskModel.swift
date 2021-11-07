//
//  TaskModel.swift
//  Tasks
//
//  Created by Admin on 6/11/21.
//

class TaskModel{
    
    var id: String?
    var identifier: String?
    var taskName: String?
    
    
    init(id: String?, identifier: String?,taskName: String?) {
        self.id = id;
        self.taskName = taskName;
        self.identifier = identifier;
    }
    
}
