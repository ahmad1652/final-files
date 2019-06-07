//
//  loginView.swift
//  AirFix
//
//  Created by Ahmad Mustafa on 4/29/19.
//  Copyright © 2019 Pixel. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class loginView: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(endTypeNumber))
        view.addGestureRecognizer(tabGesture)
    }
    @objc func endTypeNumber(){
        passwordText.endEditing(true)
        
    }
    
    @IBAction func loginBTN(_ sender: UIButton) {
        SVProgressHUD.show()
        errorLabel.isHidden = true
        Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (succ, error) in
            if error != nil{
                SVProgressHUD.dismiss()
                self.errorLabel.isHidden = false
                self.errorLabel.text = "\(String(describing: error))"
                print("Error cause \(String(describing: error))")
            }else{
                self.performSegue(withIdentifier: "goToMain", sender: self)
            }
        }
    }
    
}
