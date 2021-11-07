//
//  AddTaskViewController.swift
//  Tasks
//
//  Created by Admin on 4/11/21.
//

import UIKit
import Firebase

class AddTaskViewController: UIViewController {
    
    var refTasks: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        refTasks = Database.database().reference().child("tasks")
    }
    
    let priorities = ["Low", "Medium", "High"]
    
    @IBOutlet weak var txt_field_add_task_name: UITextField!
    
    @IBOutlet weak var picker_add_task_date: UIDatePicker!
    
    @IBOutlet weak var picker_add_task_prio: UIPickerView!
    @IBOutlet weak var picker_add_task_priority: UIPickerView!
    
    @IBAction func btn_add_task_add(_ sender: UIButton) {
        
        
        addTask()
        
    }
    
    func addTask(){
        
        
        
        
        let key2 = refTasks.childByAutoId().key
        let task = ["id": Constants.Storyboard.key,
                    "taskName": txt_field_add_task_name.text! as String,
                    "date": "singer",
                    "priority": "high",
                    "identifier": key2
                   ]
        refTasks.child(key2!).setValue(task)
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
