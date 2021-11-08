//
//  HomeViewController.swift
//  Tasks
//
//  Created by Admin on 31/10/21.
//

import UIKit

class HomeViewController: UIViewController{
    
    
    // new code start
    
    private let tasksController = ViewController()
    private let aboutController = AboutViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func logOutTapped(_ sender: UIBarButtonItem) {
        
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.signInViewController) as? SignInViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
}


