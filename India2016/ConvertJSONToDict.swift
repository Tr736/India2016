//
//  ConvertJSONToDict.swift
//  India2016
//
//  Created by Thomas Richardson on 16/06/2017.
//  Copyright © 2017 HiddenPixel. All rights reserved.
//

import Foundation

class ConvertJSONToDict {
    
private var _username : String!
private var _numberOfLikes : String!
private var _numberOfComments: String!
private var _imageURL: String!
private var _imageID : String!
private var _comment : String!


public var username : String {
    get {
        if _username == nil {
            _username = ""
        }
        return _username
    }
    set {
        _username = newValue
    }
}

public var numberOfLikes : String {
    get {
        if _numberOfLikes == nil {
            _numberOfLikes = "0"
        }
        return _numberOfLikes
    }
    set {
        _numberOfLikes = newValue
    }
}

public var numberOfComments : String {
    get {
        if _numberOfComments == nil {
            _numberOfComments = "0"
        }
        return _numberOfComments
    }
    set {
        _numberOfComments = newValue
    }
}
    

public var imageURL : String {
        get {
            if _imageURL == nil {
                _imageURL = ""
            }
            return _imageURL
        }
        set {
            _imageURL = newValue
        }
}
    
public var imageID : String {
        get {
            if _imageID == nil {
                _imageID = ""
            }
            return _imageID
        }
        set {
            _imageID = newValue
        }
}
public var comment : String {
        get {
            if _comment == nil {
                _comment = ""
            }
            return _comment
        }
        set {
            _comment = newValue
        }
}
    
    

init( data : Dictionary <String,String> ) {
    
    if let username = data["username"]  {
        
        _username = username
    }
    
    if let likes = data["likes"] {
        _numberOfLikes = likes
    }
    if let comments = data["comments"] {
        _numberOfComments = comments
    }
    if let imageURL = data["imageURL"] {
        _imageURL = imageURL
    }
    if let imageID = data["imageID"] {
        _imageID = imageID
    }
    if let comment = data["comment"] {
        _comment = comment
    }
    
}
}
