//
//  registerView.swift
//  AirFix
//
//  Created by Ahmad Mustafa on 4/29/19.
//  Copyright © 2019 Pixel. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class registerView: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(endTypeNumber))
        view.addGestureRecognizer(tabGesture)    }
    
    @objc func endTypeNumber(){
        passwordText.endEditing(true)
        
    }
    
    @IBAction func registerText(_ sender: UIButton) {
        SVProgressHUD.show()
        errorLabel.isHidden = true
        Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (suss, error) in
            if error != nil{
                SVProgressHUD.dismiss()
                self.errorLabel.isHidden = false
                self.errorLabel.text = "\(String(describing: error))"
                print("Error create accountttt \(String(describing: error))")
            }else{
                print("Sucessful create account")
                self.performSegue(withIdentifier: "goToMain", sender: self)
            }
        }
        
    }
    
   
}
