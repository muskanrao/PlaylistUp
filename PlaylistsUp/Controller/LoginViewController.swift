//
//  LoginViewController.swift
//  PlaylistsUp
//
//  Created by Muskan on 07/06/22.
//

import Foundation
import UIKit
import Firebase

class LoginViewController : UIViewController{
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var PlaylistUp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = .init(named: "Music3")
        view.addSubview(imageView)
        view.addSubview(emailText)
        view.addSubview(passwordText)
        view.addSubview(loginButton)
        view.addSubview(PlaylistUp)
        
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailText.text , let password = passwordText.text{
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
              
                if error != nil{
                    
                    let alert: UIAlertController
                    let action: UIAlertAction
                    
                    alert = .init(title: "", message: "Error while logging in.", preferredStyle: .alert)
                    action = .init(title: "OK", style: .default, handler: { (action) in
                        print("Okay pressed for log in.")
                    })
                    
                    alert.addAction(action)
                    self!.present(alert, animated: true, completion: nil)
 
                }else{
                    
                    //let senderName = us
                    
                    self!.performSegue(withIdentifier: "targetlognedin", sender: self)
                }
            
            }

        }
        
        
    }
    
}
