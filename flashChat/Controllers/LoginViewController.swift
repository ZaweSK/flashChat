//
//  LoginViewController.swift
//  flashChat
//
//  Created by Peter on 27/02/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.text = "Peter@gmail.com"
        passwordTextField.text = "123456"
       
    }
    

    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    
    @IBAction func login(_ sender: UIButton) {
      
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }else {
                print("Login succesfull")
            }
        }
        
    }
    
}
