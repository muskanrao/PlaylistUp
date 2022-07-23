//
//  StartViewController.swift
//  PlaylistsUp
//
//  Created by Muskan on 07/06/22.
//

import Foundation
import UIKit
import Lottie

class StartViewController: UIViewController{
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    var animationView : AnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        animationView = .init(name: "video")
        animationView?.frame = view.bounds
        animationView?.animationSpeed = 0.7
        view.addSubview(animationView!)
        animationView?.play()
        view.didAddSubview(animationView!)
        image.image = .init(named: "Music1")
        view.addSubview(image)
        view.addSubview(login)
        view.addSubview(signup)
        view.addSubview(label)
  
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animationView?.loopMode = .loop
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
       // performSegue(withIdentifier: "loginView", sender: self)
        
    }
    

    @IBAction func signupPressed(_ sender: UIButton) {
      //  performSegue(withIdentifier: "signupView", sender: self)
    }
    
}
