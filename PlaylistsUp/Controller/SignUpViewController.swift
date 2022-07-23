//
//  SignUpViewController.swift
//  PlaylistsUp
//
//  Created by Muskan on 07/06/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth
import SwiftUI

class SignUpViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var usrenameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var PlaylistUp: UILabel!
    
    private let storage = Storage.storage().reference()
    var urlRefrence : String = ""
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.tintColor = .gray
        userImage.contentMode = .scaleAspectFill
        userImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfile))
        userImage.addGestureRecognizer(gesture)
        userImage.layer.borderWidth = 2
        userImage.layer.borderColor = UIColor.lightGray.cgColor
        userImage.layer.cornerRadius = 50
        //userImage.clipsToBounds = true
        userImage.layer.masksToBounds = true
        imageView.image = .init(named: "Music3")
        view.addSubview(imageView)
        view.addSubview(userImage)
        view.addSubview(emailText)
        view.addSubview(passwordText)
        view.addSubview(usrenameText)
        view.addSubview(signupButton)
        view.addSubview(PlaylistUp)
        
        guard let urlString = UserDefaults.standard.value(forKey: "url") as? String , let url = URL(string: urlString) else{
            return
        }
        
       let task =  URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else{
                return
            }
            
            DispatchQueue.main.async{
                let image = UIImage(data: data)
                self.userImage.image = image
            }
        }
        
        task.resume()
        
    }
    
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler:{_ in
            self.presentCamers()
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: {_ in
            self.presentPhotoPicker()
        }))
        
        present(actionSheet, animated: true)
        
        
        
    }
    
    func presentCamers(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    func presentPhotoPicker(){
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true,completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        self.userImage.image = selectedImage
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        
        guard let imageData = image.pngData() else{
            return
        }
        
        storage.child("images/files.png").putData(imageData, metadata: nil, completion: { _, error in
            guard error == nil else{
                print("Failed to upload \(error)")
                return
            }
            
            self.storage.child("images/files.png").downloadURL(completion: { [self]url , error in
                guard let url = url , error == nil else{
                    return
                }
                
                let urlString = url.absoluteString
                print("Download URL: \(urlString)")
                urlRefrence = urlString
                UserDefaults.standard.set(urlString, forKey: "url")
                
            })
            
        })
        
       // let ref = storage.child("images/files.png")
        
        //1.Upload image data
        
        //2. get odwnload url
        
        //3. save download url to userdefaults.
        
       // self.userImage.image = selectedImage
        
    }
    

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true , completion: nil)
        
    }
    
    
    @objc func didTapChangeProfile(){
        print("Change the profile")
        presentPhotoActionSheet()
        //presentPhotoActionSheet()
    }
    
    @IBAction func signupPressed(_ sender: UIButton) {
        
        if let email = emailText.text , let password = passwordText.text{
            
            Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
                 
                if error != nil{
                    
                    let alert : UIAlertController
                    alert = .init(title: "", message: "Error while Signning Up.", preferredStyle: .alert)
                    let action : UIAlertAction
                    action =  .init(title: "OK", style: .default, handler: { (action) in
                        print("Okay Pressed")
                    })
                    
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
 
                }else{
                    
                    let senderName = self.usrenameText.text!
                    let senderMail = email
                    let imageUrl = urlRefrence
                    self.db.collection("user").addDocument(data: ["Username":senderName , "Email":senderMail , "imageUrl": imageUrl]){
                        error in
                        
                        if error != nil{
                            print("Error while saving data \(error)")
                        }else{
                            print("Successfully saved")
                        }
                    }
                    
                    //DataBase.shared.insertUser(with: Playlistuser(userName: self.usrenameText.text!, email: email))
                    
                    self.performSegue(withIdentifier: "targetsigned", sender: self)
                        
                }
            }
        }

}
    /*

extension SignUpViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you like to", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler:{_ in
            self.presentCamers()
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: {_ in
            self.presentPhotoPicker()
        }))
        
        present(actionSheet, animated: true)
        
        
        
    }
    
    func presentCamers(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    func presentPhotoPicker(){
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true,completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        self.userImage.image = selectedImage
        print(info)
        
       // self.userImage.image = selectedImage
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true , completion: nil)
        
    }
    
}*/


//let senderData = self.userImage.image!.pngData()
//let senderName =  self.usrenameText.text
// let senderEmail =   Auth.auth().currentUser?.email
/*
self.db.collection("user").addDocument(data: ["senderProfile":senderData,"senderEmail":senderEmail,"senderName":senderName]){(error) in
    if  error != nil{
        print("The error while storing data to dataBase \(error)")
    }else{
        print("Succefully saved!")
    }
 
 func loadBooking(){
     var booking = ""
     db.collection("user").getDocuments { (querySnapshot , error) in
         if error != nil{
             print("Error while loading saved data.")
         }else{
             if let snapshotDocuments = querySnapshot?.documents{
                 for doc in snapshotDocuments{
                     let data = doc.data()
                     print(Auth.auth().currentUser?.email)
                     if data["sender"] as! String  == Auth.auth().currentUser?.email {
                         booking = data["bookedSeat"] as! String
                         self.item = booking
                         print(booking)
                         self.performSegue(withIdentifier: "ToViewBook", sender: self)
                         break
                       
                     } //let booking = data["bookedSeat"] as? String{
                         
                         //self.performSegue(withIdentifier: "ToViewBook", sender: self)
                         // print(sender)
                         
                         //self.item = booking
                     }
                 }
             }
         }
     }*/
}
