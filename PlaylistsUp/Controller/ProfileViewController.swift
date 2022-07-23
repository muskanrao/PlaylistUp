//
//  ProfileViewController.swift
//  PlaylistsUp
//
//  Created by Muskan on 11/06/22.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth

class ProfileViewController: UIViewController{
    
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var quote: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProfile()
        view.addSubview(backgroundImage)
        view.addSubview(userName)
        view.addSubview(UserImage)
        view.addSubview(userEmail)
        view.addSubview(quote)
        view.addSubview(logoutButton)
        backgroundImage.image = .init(named: "final3")
        backgroundImage.contentMode = .scaleAspectFill
        
    }
    
    func loadProfile(){
        
        db.collection("user").getDocuments { querSnapshot, error in
            
            if error != nil{
                print("Error while loading the data \(error)")
            }else{
                if let snapshotDocuments = querSnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data =  doc.data()
                        print(Auth.auth().currentUser?.email)
                        
                        if data["Email"] as! String == Auth.auth().currentUser?.email{
                            
                            self.userName.text = data["Username"] as! String
                            self.userEmail.text = Auth.auth().currentUser?.email
                            let imageURL =  data["imageUrl"] as! String
                            print(imageURL)
                            let url = URL(string: imageURL)
                            
                            DispatchQueue.main.async { [weak self] in
                                       if let imageData = try? Data(contentsOf: url!) {
                                           if let loadedImage = UIImage(data: imageData) {
                                               self?.UserImage.image = loadedImage
                                           }
                                       }
                            }
                    }
                }
            }
            
        }
   }
}
    @IBAction func LogOutPressed(_ sender: UIButton) {
        
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            print("OK")
        }catch let signOutError as NSError{
            print("Error signing out: %@", signOutError)
        }
        
        navigationController?.popToRootViewController(animated: true)

    }
}
