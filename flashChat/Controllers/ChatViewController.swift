//
//  ChatViewController.swift
//  flashChat
//
//  Created by Peter on 27/02/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var messagesArray = ["Ahoj", "Volam sa Kamilko", "Nevolam sa Marcelko"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        
        do{
           try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch{
            print("Error signing out \(error)")
        }
    }
    
    
    
    // MARK : - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        
        cell.textLabel!.text = messagesArray[indexPath.row]
        
        return cell
    }
    

}
