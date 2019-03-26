//
//  ChatViewController.swift
//  flashChat
//
//  Created by Peter on 27/02/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    // MARK: - Properities
    
    var messagesArray = [Message]()
    
    // MARK: - @IBActions & @IBOutlets
    
    @IBOutlet var messageTextField: UITextField!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var sendButton: UIButton!
    
    @IBOutlet var messageViewHeightConstraint: NSLayoutConstraint!
    
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        
        do{
            
           try Auth.auth().signOut()
            
            navigationController?.popToRootViewController(animated: true)
            
        }catch{
            print("Error signing out \(error)")
        }
    }

    //saving data to DB
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
                print(error!)
            }else{
                self.messageTextField.isEnabled = true
                
                self.sendButton.isEnabled = true
                
                self.messageTextField.text = ""
            }
        }
    }
    
    // MARK: - View Controller Life cycle methods

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        messageTextField.delegate = self
        
        tableView.dataSource = self
        
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "MyMessageCell", bundle: nil), forCellReuseIdentifier: "myMessageCell")
        
        tableView.separatorStyle = .none
        
        configureTableView()
        
        retrieveMessages()
    }
    
    
    // MARK : - Table view data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myMessageCell", for: indexPath) as! MyMessageCell
        
        cell.messageBody!.text = messagesArray[indexPath.row].messageBody
        
        cell.senderName!.text = messagesArray[indexPath.row].sender
        
        cell.messageBackground.layer.cornerRadius = 5
        
        cell.selectionStyle = .none
        
        if cell.senderName.text == Auth.auth().currentUser?.email {
            
            cell.avatarImageView.backgroundColor = UIColor.flatMint()
            
            cell.messageBackground.backgroundColor = UIColor.flatSkyBlue()
            
        }else{
            
            cell.avatarImageView.backgroundColor = UIColor.flatWatermelon()
            
            cell.messageBackground.backgroundColor = UIColor.flatGray()
        }
        
        
        return cell
    }
    
    
    // MARK: - Table View Delegate Methods
    
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
            
//            print("\(sender) : \(text)")
            
            let message = Message()
            message.messageBody = text
            message.sender = sender
            
            self.messagesArray.append(message)
            
            self.configureTableView()
            
            self.tableView.reloadData()
        }
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        messageTextField.endEditing(true)
    }
}


extension ChatViewController: UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        messageViewHeightConstraint.constant = 308
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        messageViewHeightConstraint.constant = 65
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    
}
