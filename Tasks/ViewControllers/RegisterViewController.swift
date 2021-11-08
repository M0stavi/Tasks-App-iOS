//
//  RegisterViewController.swift
//  Tasks
//
//  Created by Admin on 4/11/21.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        txt_field_register_password.isSecureTextEntry = true
        txt_field_register_confirm_password.isSecureTextEntry = true

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var txt_field_register_email: UITextField!
    
    @IBOutlet weak var txt_field_register_password: UITextField!
    @IBOutlet weak var txt_field_register_confirm_password: UITextField!
    
    
    func validateFields() -> String? {
        
        
        if txt_field_register_email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || txt_field_register_password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            txt_field_register_confirm_password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
           {
            return "Please Fill in All fields"
            
        }
        return nil
            
    }
    
    
    
    @IBAction func btn_register(_ sender: UIButton) {
        
        let error = validateFields()
        if error != nil{
            
            print("LOG: Error Signing Up!")
            
        }
        else{
            
            let email = txt_field_register_email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = txt_field_register_password.text!.trimmingCharacters(in: .whitespaces)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result,err)  in
                if err != nil{
                    print("LOG: Error Creating User")
                }
                else{
                    print("Success!")
                }
            }
            
            //transition to homepage
            self.transitionToHome()
            
        }
        
    }
    
    func transitionToHome(){
        
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.signInViewController) as? SignInViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    

}
