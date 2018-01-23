//
//  FormFillInfo.swift
//  Gym Exercice
//
//  Created by Minh Nguyet on 12/18/17.
//  Copyright © 2017 if26. All rights reserved.
//

import UIKit
import SQLite

class FormFillInfo: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {


  //  @IBOutlet weak var pickerViewGenre: UIPickerView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    
    
    @IBOutlet weak var textFieldAge: UITextField!
    
    var userName  :String = ""
    var userAge :Int = 0
    var userPass  : Int = 0
    var userGenre :Int = 0
    var userImage :String = ""
    var userFavorites :String = ""
    
    var database : Connection!
    
    let userTable = Table("userTable")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let pass = Expression<Int>("pass")
    let age = Expression<Int>("age")
    let genre = Expression<Bool>("genre")
    let avaImage = Expression<String>("avaImage")
    let isActive = Expression<Bool>("isActive")
    
    var theImagePassed = UIImage()
    var isAvatarChanged = false
    
    let genres = ["Woman","Man"]
    
    
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        pickerView.delegate = self
        pickerView.dataSource = self

        do{
            
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileURL.path)
            self.database = database
          
        }
        catch{
            print(error)
        }
        if (self.isAvatarChanged){
            let imageData:NSData = UIImagePNGRepresentation(theImagePassed)! as NSData
            self.userImage = imageData.base64EncodedString(options: .lineLength64Characters)
        }else{
            getInfoUser()
        }
       // imageAvatar.image = theImagePassed
        textFieldAge.text = String(self.userAge)
        labelUserName.text = self.userName
        if(self.userImage != "images") {
            let dataDecoded : Data = Data(base64Encoded: self.userImage , options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            imageAvatar.image = decodedimage
        }else{
            imageAvatar.image = UIImage(named : self.userImage)
        }
        pickerView.selectRow(self.userGenre, inComponent:0, animated:true)
       // pickerView.selectedRow(inComponent: 1)
            
        
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return genres.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.userGenre = row
    }
    
    
    @IBAction func saveUserData() {
        
        
        let imageAva = self.userImage
        var genre : Bool = true
       if(self.userGenre == 0){
            genre = false
        }
        if let age = Int(textFieldAge.text!){
            do{
                let user = self.userTable.filter(isActive == true)
                let updateUser = user.update( [self.age <- age,
                                               self.genre <- genre,
                                               self.avaImage <- imageAva])
                try self.database.run(updateUser)
                if try self.database.run(updateUser) > 0 {
                    print("update completed")
                }
            }catch{
                print ("error update")
            }
        } else {
            let WrongAlert = UIAlertController(title: "Error sign in", message: "Your user name and password are not accepted", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (_) in }
            WrongAlert.addAction(cancelAction)
            self.present(WrongAlert, animated: true, completion: nil)
        }
    
    
    }
    
    @IBAction func changePhoto() {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "UploadPhoto") as! UploadPhoto
        myVC.theImagePassed =  imageAvatar.image!
        myVC.theAgePassed = Int(textFieldAge.text!)!
        myVC.theGenrePassed = self.userGenre
        navigationController?.pushViewController(myVC, animated: true)
        
    }
    
    func getInfoUser (){
        
            do{
                let user = try self.database.prepare("select * from userTable ")
                for row in user{
                    if (Int(row[6] as! Int64) == 1){
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
    /*  @IBAction func SaveChanges(_ sender: UIButton) {
        
        let name = textFieldName.text!
        let age = textFieldAge.text
        let genre = self.userGenre
        
       do{
           /* let user = self.userTable.filter(id == 0)
            let updateUser = user.update(self.name <- userName, self.age <- userAge, self.genre <- userGenre)*/
            try self.database.run("UPDATE userTable SET name = '\(name)', age = '\(age)', genre =\(genre)")
        }catch{
            print ("error update")
        }
    }*/
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
