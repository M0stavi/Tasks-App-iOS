//
//  HomeViewController.swift
//  Tasks
//
//  Created by Admin on 31/10/21.
//

import UIKit
import SideMenu

var list = ["anda", "dim", "mangsho"]
var count = 0




class HomeViewController: UIViewController, MenuControllerDelegate{
    
    
    // new code start
    
    private var sideMenu: SideMenuNavigationController?
    
    private let tasksController = ViewController()
    private let aboutController = AboutViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = MenuController(with: ["Home" , "Tasks", "About", "Log out" , "Exit"])
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        
        sideMenu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        addChildControllers()
    }
    
    
    @IBAction func logOutTapped(_ sender: UIBarButtonItem) {
        
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.signInViewController) as? SignInViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    private func addChildControllers(){
        addChild(tasksController)
        addChild(aboutController)
        
        view.addSubview(tasksController.view)
        view.addSubview(aboutController.view)
        
        tasksController.view.frame = view.bounds
        aboutController.view.frame = view.bounds
        
        tasksController.didMove(toParent: self)
        aboutController.didMove(toParent: self)
        
        tasksController.view.isHidden = true
        aboutController.view.isHidden = true
    }
    
    
    
    @IBAction func didTapMenuButton(){
        present(sideMenu!, animated: true)
        
    }
    
    func didSelectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true, completion: {[weak self] in
            
            self?.title = named
            
            if named == "Home"{
                self?.tasksController.view.isHidden = true
                self?.aboutController.view.isHidden = true
            }
            else if named == "Tasks"{
                self?.tasksController.view.isHidden = false
                
                self?.aboutController.view.isHidden = true
            }
                
            else if named == "About"{
                self?.tasksController.view.isHidden = true
                self?.aboutController.view.isHidden = false
            }
            else if named == "Log out"{
                
            }
            else if named == "Exit" {
                
            }
            
        })
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // new code end
    
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "dept")
//        cell.textLabel?.text = list[indexPath.row]
//
//        return cell
//    }
//
//
//
//    var menu: SideMenuNavigationController?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//
//
//        menu = SideMenuNavigationController(rootViewController: MenuListController())
//        menu?.leftSide = true
//        menu?.setNavigationBarHidden(true, animated: false)
//
//        SideMenuManager.default.leftMenuNavigationController = menu
//        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
//
//    }
//
//    @IBAction func didTapMenu(){
//        present(menu!, animated: true)
//    }
    
    // left side menu controller
    
    
   
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class MenuListController:UITableViewController{
    
    public var delegate: MenuControllerDelegate?
    
    
    var items = ["Home", "Tasks", "About", "Logout","Exit"]
    let darkColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = darkColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = darkColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedItem = list[indexPath.row]
        
        delegate?.didSelectMenuItem(named: selectedItem)
    }
}
