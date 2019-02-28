//
//  LoginViewController.swift
//  flashChat
//
//  Created by Peter on 27/02/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController
{

    // MARK: - @IBActions & @IBOutlets
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBAction func login(_ sender: UIButton) {
        
        SVProgressHUD.show()
      
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
               
                // TODO: - present user with error
               
                SVProgressHUD.dismiss()
                
            }else {
                
                SVProgressHUD.dismiss()
                
                print("Login succesfull")
                
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
    }
}
