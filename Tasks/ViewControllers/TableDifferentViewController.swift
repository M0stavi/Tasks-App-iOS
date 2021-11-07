//
//  TableDifferentViewController.swift
//  Tasks
//
//  Created by Admin on 7/11/21.
//

import UIKit
import Firebase

class TableDifferentViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath) as! ViewControllerTableViewCell
        let task: MyModel
        
        task = tasksList[indexPath.row]
        
        cell.lblName.text = task.taskName
        cell.lblGenre.text = task.date
        
        if(task.priority! == "low"){
            cell.backgroundColor = .green
        }
        
        else if(task.priority! == "medium"){
            cell.backgroundColor = .yellow
        }
        
        else if(task.priority! == "high"){
            cell.backgroundColor = .cyan
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    

    @IBOutlet weak var tblMyTask: UITableView!
    
    var refTasks : DatabaseReference!
    var tasksList = [MyModel]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let task = tasksList[indexPath.row]
        
        let alertController = UIAlertController(title: task.taskName, message: "example", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default){(_) in
            
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default){(_) in
            
            let idid = task.identifier!
            self.deleteArtist(identifier: idid)
            
        }
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated:true, completion: nil)
        
        
        
        
        
        
        
        
        
    }
    
    
    
    func deleteArtist(identifier: String){
        
        refTasks.child(identifier).setValue(nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        refTasks = Database.database().reference().child("tasks");
        
        refTasks.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.tasksList.removeAll()
                
                for tasks in snapshot.children.allObjects as![DataSnapshot]{
                    
                    let taskObject = tasks.value as? [String: AnyObject]
                    let taskName = taskObject?["taskName"]
                    let taskDemo = taskObject?["date"]
                    let taskId = taskObject?["id"]
                    let taskPriority = taskObject?["priority"]
                    let taskIdentifier = taskObject?["identifier"]
                    
                    
                    let task  = MyModel(id: taskId as! String?, taskName: taskName as! String?, date: taskDemo as! String?, priority: taskPriority as! String?, identifier: taskIdentifier as! String?)
                    
                    
                    
                    let compare1 = task.id!
                    //print("Herehere")
                    //print(compare1)
                    let compare2 = Constants.Storyboard.key
                    //print(compare2)
                    if(compare1 == compare2){
                        self.tasksList.append(task)
                    }
                    
                }
                
                self.tblMyTask.reloadData()
            }
            
        })
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
