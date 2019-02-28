//
//  RegisterViewController.swift
//  flashChat
//
//  Created by Peter on 27/02/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
  

    @IBAction func register(_ sender: UIButton) {
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in

            if error != nil {
                print(error)
            }else{
                print("Success")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "goToChat", sender: self)
                
            }
            
        }
    }
}
