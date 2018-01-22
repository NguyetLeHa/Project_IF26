//
//  Authentification.swift
//  Gym Exercice
//
//  Created by Minh Nguyet on 1/15/18.
//  Copyright © 2018 if26. All rights reserved.
//

import UIKit
import SQLite

class Authentification: UIViewController {

   
   
    @IBOutlet weak var userNameLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    
    
   
    
    let userTable = Table("userTable")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let pass = Expression<Int>("pass")
    let age = Expression<Int>("age")
    let genre = Expression<Bool>("genre")
    let avaImage = Expression<String>("avaImage")
    let isActive = Expression<Bool>("isActive")
    var database : Connection!
    var userName : String = ""
    var userPass : Int = 0
    var successLogIn : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordLabel.isSecureTextEntry = true
        do{
            
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileURL.path)
            self.database = database
            
        }
        catch{
            print(error)
        }
        createTable()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func createTable() {
       do{
         try  self.database.run(self.userTable.drop())
         }
         catch{
         print("error created")
         }
        
        let createTable = self.userTable.create(ifNotExists: true) { (table) in
            table.column(id, primaryKey: true)
            table.column(name, unique : true)
            table.column(pass)
            table.column(age)
            table.column(genre)
            table.column(avaImage)
            table.column(isActive)
        }
        
        do{
            try self.database.run(createTable)
        
            
        }catch{
            print("error created")
        }
        
    }
    
    @IBAction func insertUser() {
        let alertController = UIAlertController(title: "Create a account", message: "Enter your user name and password", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Valid", style: .default) { (_) in
            
            //getting the input values from user
            let name = alertController.textFields?[0].text
            let pass = (alertController.textFields?[1].text)!
            let confirmPass = alertController.textFields?[2].text
            
            
            
            if ((pass == confirmPass) && !(pass.isEmpty) && !(name?.isEmpty)!) {
                let insertUser = self.userTable.insert(self.name <- name!,self.pass <- pass.hashValue, self.age <- 0, self.genre <- true, self.avaImage <- "images", self.isActive <- false)
                do {
                    try self.database.run(insertUser)
                    self.userNameLabel.text = name
                    self.passwordLabel.text = pass
                    print("Successful sign in")
                    
                }
                catch{
                    print("error Inscription")
                    let WrongAlert = UIAlertController(title: "Error sign in", message: "Your user name and password are not accepted", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (_) in }
                    WrongAlert.addAction(cancelAction)
                    
                    self.present(WrongAlert, animated: true, completion: nil)
                }
                
            } else {
                let WrongAlert = UIAlertController(title: "Error sign in", message: "Your user name and password are not accepted", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (_) in }
                WrongAlert.addAction(cancelAction)
                self.present(WrongAlert, animated: true, completion: nil)
            }
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter user name"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter password"
            textField.isSecureTextEntry = true
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Confirm your password"
            textField.isSecureTextEntry = true
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func signUp() {
        do{
            let user = try self.database.prepare("select * from userTable ")
            let nameUser = self.userNameLabel.text
            self.userPass = ( self.passwordLabel.text?.hashValue)!
            for row in user{
                if((self.userNameLabel.text == row[1] as? String) && (self.userPass == Int(row[2] as! Int64))){
                    self.successLogIn = true
                    self.userName = row[1] as! String
                    print("succes log in")
                    
                    let user = self.userTable.filter(self.name == nameUser!)
                    let updateUser = user.update(self.isActive <- true)
                    do{
                        try self.database.run(updateUser)
                    }catch{
                        print ("error active")
                    }
                }
                
            }
            if(self.successLogIn ){
                let myVC = storyboard?.instantiateViewController(withIdentifier: "HomeScreen") as! UITabBarController
                navigationController?.pushViewController(myVC, animated: true)
                
            } else {
                print("error Log In")
                let WrongAlert = UIAlertController(title: "Error log in", message: "Your user name and password are not accepted", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (_) in }
                WrongAlert.addAction(cancelAction)
                self.present(WrongAlert, animated: true, completion: nil)
            }
            
            
        }catch{
                print("error log in")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
