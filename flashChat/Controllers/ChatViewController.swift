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
    
    var messagesArray = ["Ahoj", "Volam sa Kamilko asdsdsd sds dsdsd sd sdsd sd sdsd sd fdf fdfdfd fdfdf dfdffd fdfdf fdfdfd fdf dfdfdf df fdfdf df dfd fdf f ", "Nevolam sa Marcelko"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "MyMessageCell", bundle: nil), forCellReuseIdentifier: "myMessageCell")
        
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "myMessageCell", for: indexPath) as! MyMessageCell
        
       cell.messageBody!.text = messagesArray[indexPath.row]
        

        
        return cell
    }
    
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

}
