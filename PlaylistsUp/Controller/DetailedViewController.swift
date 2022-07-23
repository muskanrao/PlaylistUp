//
//  DetailedViewController.swift
//  PlaylistsUp
//
//  Created by Muskan on 06/06/22.
//

import UIKit
import WebKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var textView: UITextView!
    
    var video : Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        titleLabel.text = ""
        dateLabel.text = ""
        textView.text = ""
        
        
        guard video != nil else{
            fatalError()
        }
        
        let embedUrl  = Constants.ytEmbedUrl + video!.videoId
        let url = URL(string: embedUrl)
        let request = URLRequest(url: url!)
        webView.load(request)
        
        titleLabel.text = video?.title
        
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        dateLabel.text = df.string(from: video!.published)
        
        textView.text = video?.description
        
    }
    
    
    

}
