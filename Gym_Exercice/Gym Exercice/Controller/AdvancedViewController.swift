//
//  AdvancedViewController.swift
//  Gym Exercice
//
//  Created by Minh Nguyet on 12/12/17.
//  Copyright © 2017 if26. All rights reserved.
//

import UIKit
import SQLite

class AdvancedViewController: UIViewController {

   // @IBOutlet weak var labelNameUser: UILabel!
    @IBOutlet weak var labelGenreUser: UILabel!
    @IBOutlet weak var labelNameUser: UILabel!
    @IBOutlet weak var labelAgeUser: UILabel!
    @IBOutlet weak var ImageAvatar: UIImageView!
    
    @IBOutlet weak var nameProfil: UITabBarItem!
    
    let userTable = Table("userTable")
    let name = Expression<String>("name")
    let pass = Expression<Int>("pass")
    let isActive = Expression<Bool>("isActive")
    
    
    var userName  :String = ""
    var userAge :Int = 0
    var userGenre :Int = 0
    var userImage :String = ""
    var userPass : Int = 0
    var userFavorites :String = ""
    var database : Connection!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do{
            
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileURL.path)
            self.database = database
            
        }
        catch{
            print(error)
        }
        
        getInfomationUser()
        labelNameUser.text = self.userName
        labelAgeUser.text = String( self.userAge)
        labelNameUser.text = self.userName
        if (self.userImage != "images"){
            let dataDecoded : Data = Data(base64Encoded: self.userImage , options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            ImageAvatar.image = decodedimage
            print("image ok")
            
        }else{
            ImageAvatar.image = UIImage(named : self.userImage)
        }
        
        if(self.userGenre != 0){
            labelGenreUser.text = "man"
        } else{
             labelGenreUser.text = "woman"
        }
        nameProfil.title = self.userName
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func getInfomationUser(){
        
        
        do{
            let user = try self.database.prepare("select * from userTable ")
            for row in user{
                if (Int(row[6] as! Int64) == 1 ){
                    self.userName =  row[1] as! String
                    self.userPass = Int(row[2] as! Int64)
                    self.userAge =  Int(row[3] as! Int64)
                    self.userGenre =  Int(row[4] as! Int64)
                    self.userImage =  row[5] as! String
                }
                   }
            
        
        }catch{
            print("error getInfo")
        }
    }
    
    @IBAction func GuideGym() {
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "GuideGym") as! GuideGym
        myVC.userGenre = self.userGenre
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    @IBAction func logOut() {
        let user =  self.userTable.filter(name == self.userName)
        let desactiveUser = user.update(self.isActive <- false)
        do{
            try self.database.run(desactiveUser)
            let myVC = storyboard?.instantiateViewController(withIdentifier: "Authentification") as! UIViewController
            navigationController?.pushViewController(myVC, animated: true)
        }catch{
            print ("error desactive")
        }
        
    }
    
    @IBAction func changePass() {
        let alertController = UIAlertController(title: "Change your password", message: "Enter your old password name and the new", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Valid", style: .default) { (_) in
            
            //getting the input values from user
            let oldPass = alertController.textFields?[0].text?.hashValue
            let pass = (alertController.textFields?[1].text)!
            let confirmPass = alertController.textFields?[2].text
            let nameUser = self.userName
            
            
            if ((pass == confirmPass) && !(pass.isEmpty) && (oldPass == self.userPass)) {
                let user =  self.userTable.filter(self.name == nameUser)
                let updatePass = user.update(self.pass <- pass.hashValue)
                do {
                    try self.database.run(updatePass)
                    print("Successful change pass ")
                    let SuccessAlert = UIAlertController(title: "Success Change Password", message: "You change successfully yours password", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (_) in }
                    SuccessAlert.addAction(cancelAction)
                    
                    self.present(SuccessAlert, animated: true, completion: nil)
                    
                }
                catch{
                    print("error Change pass")
                    let WrongAlert = UIAlertController(title: "Error Change Password", message: "You can not change yours password", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (_) in }
                    WrongAlert.addAction(cancelAction)
                    
                    self.present(WrongAlert, animated: true, completion: nil)
                }
                
            } else {
                let WrongAlert = UIAlertController(title: "Error Change Password", message: "You can not change yours password", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (_) in }
                WrongAlert.addAction(cancelAction)
                
                self.present(WrongAlert, animated: true, completion: nil)
            }
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter the old password"
            textField.isSecureTextEntry = true
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter the new password"
            textField.isSecureTextEntry = true
            
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Confirm your new password"
            textField.isSecureTextEntry = true
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    

}
