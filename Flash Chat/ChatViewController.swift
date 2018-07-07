//
//  ViewController.swift
//  Flash Chat
//
//  Created by Abdullah Alhaider on 12/14/17.
//  Copyright © 2018 Abdullah Alhaider. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

class ChatViewController: UIViewController {
    
    // Declaring instance variable
    var messageArray : [Message] = [Message]()
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureTableView()
        retrieveMessages()
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    
    func setup(){
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTableView.separatorStyle = .none
        
        messageTextfield.delegate = self
        
        // Setting the tapGesture :
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
        
        // Registering MessageCell.xib file :
        messageTableView.register(UINib(nibName : "MessageCell", bundle : nil), forCellReuseIdentifier: "customMessageCell")
    }
    
    
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }
    
    
    func configureTableView() {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    

    func send(){
        
        messageTextfield.endEditing(true)
        // Sending the message to Firebase and save it in our database
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        let messagesDB = Database.database().reference().child("Messages")
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email, "MessageBody": messageTextfield.text!]
        
        messagesDB.childByAutoId().setValue(messageDictionary){
            (error, reference) in
            
            if error != nil {
                print("\nError is \(error!)")
            }else{
                print("\nMessage saved seccessfully :)")
                
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextfield.text = ""
            }
        }
    }
    
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        send()
    }
    
    
    
    func retrieveMessages() {
        
        let messageDB = Database.database().reference().child("Messages")
        
        messageDB.observe(.childAdded) { (snapshot) in
            
            // This is not the best practice to to it, you may use (guard) or (if let) ..
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let text = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            print("\n\(text)\n\(sender)")
            let message = Message()
            message.messageBody = text
            message.sender = sender
            
            self.messageArray.append(message)
            self.configureTableView()
            self.messageTableView.reloadData()
        }
    }
    

    
    func logout (){
        // Logging out the user and send them back to WelcomeViewController
        do{
            try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
        }catch{
            print("error!.. there is a problem sign out!")
        }
    }
    
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        logout()
    }
    


}


extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        
        //        let messageArray = ["First message","Second message ","Third message"]
        //        cell.messageBody.text = messageArray[indexPath.row]
        
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        cell.avatarImageView.image = UIImage(named : "egg")
        
        if cell.senderUsername.text == Auth.auth().currentUser?.email as String? {
            //message we sent
            cell.avatarImageView.backgroundColor = UIColor.flatMint()
            cell.messageBackground.backgroundColor = UIColor.flatRed()
        }else{
            cell.avatarImageView.backgroundColor = UIColor.flatBlue()
            cell.messageBackground.backgroundColor = UIColor.flatGray()
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
}


extension ChatViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.7){
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.7){
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
}
