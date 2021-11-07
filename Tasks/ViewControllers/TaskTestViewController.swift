//
//  TaskTestViewController.swift
//  Tasks
//
//  Created by Admin on 6/11/21.
//

import UIKit

class TaskTestViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    let myData = ["firt" , "second" , "htih" , "gahuifghuiagh"]
    
    
    @IBOutlet var taskTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
    
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = myData[indexPath.row]
        return cell
    }
    

    

}
