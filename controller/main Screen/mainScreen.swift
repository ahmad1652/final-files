//
//  mainScreen.swift
//  AirFix
//
//  Created by Ahmad Mustafa on 4/30/19.
//  Copyright © 2019 Pixel. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class mainScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var mainTableView: UITableView!
    
    let selectMenu = ["Augmented Reality","CoreML","goToChat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.instance.getBrand().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "mainTable", for: indexPath) as? menuCellTableViewCell{
            // bring every row line and put in each row
            let currentRowBrand = Data.instance.getBrand()[indexPath.row]
            cell.brandView(brand: currentRowBrand)
            return cell // return empty
        }else{
            return menuCellTableViewCell()
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return tableView.frame.width / 1.25
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectIndex = Data.instance.getBrand()[indexPath.row]
        performSegue(withIdentifier: selectMenu[indexPath.row], sender: selectIndex)
    }
    
    @IBAction func logout(_ sender: UIButton) {
       SVProgressHUD.show()
        do{
            try Auth.auth().signOut()
            SVProgressHUD.dismiss()
            performSegue(withIdentifier: "logout", sender: nil)
        }catch{
            SVProgressHUD.dismiss()
            print("error")
        }
        
    }
    

}
