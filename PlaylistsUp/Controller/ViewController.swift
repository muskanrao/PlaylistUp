//
//  ViewController.swift
//  PlaylistsUp
//
//  Created by Muskan on 06/06/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController , UITableViewDataSource,UITableViewDelegate, ModelDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileButton: UIBarButtonItem!
    
    
    var model = Model()
    var videos = [Video]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // view.addSubview(profileImageView)
      
      //  containerView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor,  height: 300)
        model.getVideo()
        tableView.dataSource = self
        tableView.delegate = self
        model.delegate = self
        tableView.backgroundColor = UIColor.black
      //  profileImageView.anchor(top: view.topAnchor, left: view.leftAnchor,  paddingTop: 44, paddingleft: 32,  width: 120, height: 120)
        //navigationItem.title = "Playlist"
        
        model.getVideo()

    
    }
    
   // MARK: -Model delegate Methods
    
    func videoFetched(_ videos: [Video]) {
        
        self.videos = videos
        
        tableView.reloadData()
        
    }
    
    
  //  MARK: -Data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.videoCell, for: indexPath) as! VideoTableViewCell
        
        cell.setCell(videos[indexPath.row])
        
        //get title
        //let title  = self.videos[indexPath.row].title
        
       // cell.textLabel?.text = title
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       performSegue(withIdentifier: "target", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
        guard tableView.indexPathForSelectedRow != nil else{
            fatalError()
        }
        */
        if segue.identifier == "target"{
            let directVc = segue.destination as! DetailedViewController
            directVc.video = videos[tableView.indexPathForSelectedRow!.row]
        }

    }
    
}
