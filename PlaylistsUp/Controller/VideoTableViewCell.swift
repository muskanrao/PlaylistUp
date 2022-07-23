//
//  VideoTableViewCell.swift
//  PlaylistsUp
//
//  Created by Muskan on 06/06/22.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var thumnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var video: Video?
    
    func setCell(_ v:Video){
        
        self.video = v
        
        guard self.video != nil else{
            fatalError()
        }
        
        self.titleLabel.text = video?.title
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        self.dateLabel.text = df.string(from: video!.published)
        
        guard self.video!.thumbnail != "" else{
            fatalError()
        }
        
        let url = URL(string: self.video!.thumbnail)
        
        let session = URLSession.shared
        
        let dataTask  = session.dataTask(with: url!) { data, response, error in
            
            if error == nil && data != nil{
                
                if url?.absoluteString != self.video?.thumbnail{
                    
                    return
                    
                }
                
                let image = UIImage(data: data!)
                
                DispatchQueue.main.async {
                    self.thumnailImageView.image = image
                }
                
            }
            
        }
        dataTask.resume()
    }
    
}
