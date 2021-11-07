//
//  MyModel.swift
//  Tasks
//
//  Created by Admin on 7/11/21.
//
class MyModel{
    
    var id : String?
    var taskName: String?
    var date: String?
    var priority: String?
    var identifier: String?
    init(id: String?, taskName: String? , date: String?, priority: String?, identifier: String?) {
        self.id = id;
        self.taskName = taskName;
        self.date = date;
        self.priority = priority
        self.identifier = identifier
    }
}
