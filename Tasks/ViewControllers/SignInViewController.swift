//
//  SignInViewController.swift
//  Tasks
//
//  Created by Admin on 4/11/21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        txt_field_signin_password.isSecureTextEntry = true
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var txt_field_signin_email: UITextField!
    
    @IBOutlet weak var txt_field_signin_password: UITextField!
    
    
    @IBAction func btn_signin(_ sender: UIButton) {
        
        let email = txt_field_signin_email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = txt_field_signin_password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil{
                print("Please Enter Email/ Password correctly!")
            }
            
            else{
                var str1 = self.txt_field_signin_email.text!
                str1 = str1.replacingOccurrences(of: ".", with: "@", options: NSString.CompareOptions.literal, range: nil)
                print(str1)
                Constants.Storyboard.key = str1
                print(Constants.Storyboard.key)
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController)
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
            
        }
        
    }
    
    

}
