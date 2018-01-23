//
//  UploadPhoto.swift
//  Gym Exercice
//
//  Created by Minh Nguyet on 12/31/17.
//  Copyright © 2017 if26. All rights reserved.
//

import UIKit

class UploadPhoto: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
   
    var theImagePassed = UIImage()
    var theAgePassed : Int = 0
    var theGenrePassed :Int = 0

    @IBOutlet weak var ImageAva: UIImageView!
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        super.viewDidLoad()
        ImageAva.image = theImagePassed
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openCameraButton(_ sender: Any) {
         print("take photo")
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func openPhotoLibraryButton(_ sender: Any) {
       
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
     @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            ImageAva.image = pickedImage
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func changePhoto() {
        
        let myVC = storyboard?.instantiateViewController(withIdentifier: "FormFillInfo") as! FormFillInfo
        myVC.theImagePassed = ImageAva.image!
        myVC.isAvatarChanged = true
        myVC.userAge = theAgePassed
        myVC.userGenre = theGenrePassed
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    
    @IBAction func cancelChange() {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "FormFillInfo") as! FormFillInfo
        myVC.theImagePassed = theImagePassed
        myVC.isAvatarChanged = false
        myVC.userAge = theAgePassed
        myVC.userGenre = theGenrePassed
        navigationController?.pushViewController(myVC, animated: true)
        
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
