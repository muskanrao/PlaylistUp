//
//  Model.swift
//  PlaylistsUp
//
//  Created by Muskan on 06/06/22.
//

import Foundation

protocol ModelDelegate{
    func videoFetched(_ videos:[Video])
}

class Model{
    
    var delegate: ModelDelegate?
    
    func getVideo(){
        
        //create url
        let url = URL(string: Constants.apiUrl)
        print(url!)
        
        guard url != nil else{
            fatalError()
        }
        //url session
        let session = URLSession.shared
        //data task
        let dataTask  = session.dataTask(with: url!) { data, response, error in
            
            if error != nil || data == nil{
                print(error!)
                return
            }
            //parse data into a video object
            do{
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(Response.self, from: data!)
                
                print(response)
                
                if response.items != nil{
                    
                    DispatchQueue.main.async {
                        self.delegate?.videoFetched(response.items!)
                    }
                    
                }
                
                
            }catch{
                
            }
            
            
        }
        //kick off the task
        dataTask.resume()
        
    }
}
