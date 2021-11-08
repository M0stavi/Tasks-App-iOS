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
        picker_priority.dataSource = self
        picker_priority.delegate = self
        createDatePicker()
    }
    
    let priorities = ["Low", "Medium", "High"]
    
    @IBOutlet weak var txt_field_add_task_name: UITextField!
    
    @IBOutlet weak var txt_field_datepicker: UITextField!
    
    
    let datePicker = UIDatePicker()
    var priority_selected: String?
    
    @IBOutlet weak var picker_priority: UIPickerView!
    
    @IBOutlet weak var taskStatus: UILabel!
    @IBAction func btn_add_task_add(_ sender: UIButton) {
        
        
        addTask()
        
    }
    
    func addTask(){
        
        
        
        
        let key2 = refTasks.childByAutoId().key
        let task = ["id": Constants.Storyboard.key,
                    "taskName": txt_field_add_task_name.text! as String,
                    "date": txt_field_datepicker.text! as String,
                    "priority": priority_selected! as String,
                    "identifier": key2
                   ]
        refTasks.child(key2!).setValue(task)
        
        print(task)
        txt_field_datepicker.text! = ""
        txt_field_add_task_name.text = ""
        taskStatus.text = "Task Added Successfully!"
        
        let delay = 0.5
        perform(#selector(self.delayFunction), with: nil, afterDelay: delay)
        
        
        
        
    }
    
    @objc func delayFunction(){
        taskStatus.text = ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        priority_selected = priorities[row].lowercased()
    }
    
    
    
    func createToolbar() -> UIToolbar{
        //toolbar
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //done button
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        
        toolbar.setItems([doneBtn], animated: true)
        
        return toolbar
    }
    
    
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        txt_field_datepicker.textAlignment = .center
        txt_field_datepicker.inputView = datePicker
        txt_field_datepicker.inputAccessoryView = createToolbar()
    }
    
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        
        
        self.txt_field_datepicker.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
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

extension AddTaskViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorities.count
    }
    
    
}
extension AddTaskViewController: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorities[row]
    }
    
}


