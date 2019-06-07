//
//  liveChat.swift
//  AirFix
//
//  Created by Ahmad Mustafa on 5/3/19.
//  Copyright © 2019 Pixel. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class liveChat: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var messageArray: [Message] = [Message]()

    @IBOutlet weak var textChatFiled: UITextField!
    
    @IBOutlet weak var messageTable: UITableView!
    
    @IBOutlet weak var btn: UIButton!
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        messageTable.delegate = self
        messageTable.dataSource = self
        
        // deleagate chat from previces words
        textChatFiled.delegate = self
        
        //Register our cells from Xib file customeTableCells
        
        messageTable.separatorStyle = .none
        
        
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(endTypeNumber))
        messageTable.addGestureRecognizer(tabGesture)
        
        
        // recive the data
        resiveTheRealTimeData()
      
    }
    
    @objc func endTypeNumber(){
        textChatFiled.endEditing(true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chat", for: indexPath) as! customeCells
        cell.imageAvater.image = UIImage(named: "usrIcon")
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.messageSender.text = messageArray[indexPath.row].sender
        
        if cell.messageSender.text == Auth.auth().currentUser?.email{
            // this msg send by me
            cell.viewChatBackgournd.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }else{
            // this msg from another usr
            cell.viewChatBackgournd.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }

        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @IBAction func sendMessageBTN(_ sender: UIButton) {
        textChatFiled.endEditing(true)
        
        // start send the data
        textChatFiled.isEnabled = false
        btn.isEnabled = false
        
        let messageDB = Database.database().reference().child("Messages")
        let messageDictinory = ["Sender": Auth.auth().currentUser?.email,"MessagesBody":textChatFiled.text!]
        
        messageDB.childByAutoId().setValue(messageDictinory){
            (error, reference) in
            if error != nil{
                print(error as Any)
            }else{
                print("Suessful send the data to the cloud")
                self.textChatFiled.isEnabled = true
                self.btn.isEnabled = true
                self.textChatFiled.text = ""
            }
        }
    }
    
    func resiveTheRealTimeData(){
        let messageDB = Database.database().reference().child("Messages")
        messageDB.observe(.childAdded ,with: { (snapshot) in
            let snapShotValue = snapshot.value as! Dictionary <String , String>
            let text = snapShotValue["MessagesBody"]!
            let sender = snapShotValue["Sender"]!
            let message = Message()
            message.messageBody = text
            message.sender = sender
            
            self.messageArray.append(message)//save all msg to main array
           // self.configureTableView()
          
            
            DispatchQueue.main.async(execute: {
                SVProgressHUD.dismiss()
                self.messageTable.reloadData()
                
            })
            
        })
    }
    
    //TODO: Declare configureTableView here:
    
    
    ///////////////////////////////////////////
 

    
    
   
    
}

class customeCells: UITableViewCell{
    @IBOutlet weak var imageAvater : UIImageView!
    @IBOutlet weak var viewChatBackgournd : UIView!
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var messageSender: UILabel!
}
