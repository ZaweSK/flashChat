//
//  ChatViewController.swift
//  flashChat
//
//  Created by Peter on 27/02/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    var messagesArray = [Message]()

    
    // MARK: - View Controller Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "MyMessageCell", bundle: nil), forCellReuseIdentifier: "myMessageCell")
        
        tableView.separatorStyle = .none
        
        configureTableView()
        
        retrieveMessages()
    }
    
    // MARK: - @IBActions & @IBOutlets
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        
        do{
           try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch{
            print("Error signing out \(error)")
        }
    }
    
    @IBOutlet var sendButton: UIButton!
    
    @IBAction func send(_ sender: UIButton) {
        messageTextField.endEditing(true)
        
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        let messagesDB = Database.database().reference().child("Messages")
        
        let messageDictionary = [
            "Sender": Auth.auth().currentUser?.email,
            "MessageBody" : messageTextField.text!
        ]
        
        messagesDB.childByAutoId().setValue(messageDictionary) { (error, reference) in
            if error != nil {
                print(error)
            }else{
                print("Message saved succesfully")
                
                self.messageTextField.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextField.text = ""
            }
        }
        
    }
    @IBOutlet var messageTextField: UITextField!
    
    
    
    // MARK : - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myMessageCell", for: indexPath) as! MyMessageCell
        
       cell.messageBody!.text = messagesArray[indexPath.row].messageBody
       cell.senderName!.text = messagesArray[indexPath.row].sender
        
        cell.messageBackground.layer.cornerRadius = 5
        
        return cell
    }
    
    
    // MARK: - Table View Delegate
    
    func configureTableView(){
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: - Retrieving the messages from DB
    func retrieveMessages(){
        
        let messageDB = Database.database().reference().child("Messages")
        
        messageDB.observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            
            print("\(sender) : \(text)")
            
            let message = Message()
            message.messageBody = text
            message.sender = sender
            
            self.messagesArray.append(message)
            self.configureTableView()
            self.tableView.reloadData()
        }
    }
}