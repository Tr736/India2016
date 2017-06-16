//
//  ParseData.swift
//  India2016
//
//  Created by Thomas Richardson on 16/06/2017.
//  Copyright © 2017 HiddenPixel. All rights reserved.
//

import Foundation
import SwiftyJSON

class ParseData {
    
    private var _array = [ConvertJSONToDict]()
    var array : [ConvertJSONToDict] {
        return _array
    }
    
    func authenticate(authComplete : @escaping DownloadComplete){
        
        let urlString = "http://default-environment-7p45veqn6g.elasticbeanstalk.com/api/feed?event_id=3&user_id=3&token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjMsImlzcyI6Imh0dHA6XC9cL2RlZmF1bHQtZW52aXJvbm1lbnQtN3A0NXZlcW42Zy5lbGFzdGljYmVhbnN0YWxrLmNvbVwvYXBpXC9hdXRoZW50aWNhdGUiLCJpYXQiOjE0OTc1NjMyNDYsImV4cCI6MTQ5ODc3Mjg0NiwibmJmIjoxNDk3NTYzMjQ2LCJqdGkiOiI4OWZkZGNkNTNlNDdhM2ZiYTY2ZDU0OGM1M2E5NjgwMCJ9.ZWjYFLnK4Q_hQjWOMrlqfy2NQL_wKbICHOXA2h8p0VY"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                // we're OK to parse!
                print("We Are Ok TO Parse")
                parse(json: json) {
                    
                }
                authComplete()
                return
            }
        }
        showError()
        
        
        
    }
    
    func fetchComments(imageID : String ,fetchComplete : @escaping DownloadComplete) {
        
        let urlString = mainURLForComments + imageID + tokenURLForComments
            print(imageID)
       // print(urlString)
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                // we're OK to parse!
                print("We Are Ok TO Parse Comments")
                parseComments(json: json, completed: {
                    
                })
        
                fetchComplete()
                return
            }
        }
        showError()
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        
        // TODO: Show error on root VC
       // present(ac, animated: true)
    }

    
    func parseComments(json : JSON , completed : @escaping DownloadComplete) {
        var dictToPass = [String : String]()
        
        
       // print("json = \(json)")
        for snapshot in json.arrayValue {
            
            for snap in snapshot {
                let dict = [snap.0 : snap.1]
                
                if let comment = dict["comment"] {
                    
                    dictToPass["comment"] = comment.stringValue
                }
                
                if let userName = dict["user"]?["username"] {
                    
                    dictToPass["username"] = userName.stringValue
                    
                }
     
            }
            let objects =  ConvertJSONToDict(data: dictToPass)
            _array.append(objects)
        }
        

    }
    func parse(json: JSON, _ completed: @escaping DownloadComplete ) {
        var dictToPass = [String : String]()

        for snapshot in json["data"].arrayValue {
            
            
            for snap in snapshot {
                let dict = [snap.0 : snap.1]
                
               // print("\(dict)")
                
                if let userName = dict["user"]?["username"] {
                    
                    dictToPass["username"] = userName.stringValue
           

                }
                
                if let likesCount = dict["likes_count"]?.arrayValue{
                    for likes in likesCount {
                       
                        let likeString = likes["likes"]
                        dictToPass["likes"] = likeString.stringValue
                        let imageID = likes["image_id"]
                        dictToPass["imageID"] = imageID.stringValue
                    
                    }
                
                }
                
                if let commentCount = dict["comments_count"]?.arrayValue{
                    for comments in commentCount {
                        let commentsString = comments["comments"]
                        dictToPass["comments"] = commentsString.stringValue

                    }
                    
                }
                
                
                if let imageURL = dict["image_url"] {
                    dictToPass["imageURL"] = imageURL.stringValue
                }
        
            }

            let objects =  ConvertJSONToDict(data: dictToPass)
            _array.append(objects)
        }
    

      // print(dictToPass)

        completed()
    }
}
