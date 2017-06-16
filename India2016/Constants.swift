//
//  Constants.swift
//  India2016
//
//  Created by Thomas Richardson on 15/06/2017.
//  Copyright © 2017 HiddenPixel. All rights reserved.
//

import Foundation
import UIKit

let Color_HeaderGray = UIColor(rgb: 0xf3f3f3)
let Color_BodyGray = UIColor(rgb: 0xeeeeee)
let Color_HighlightBlue = UIColor(rgb: 0x0a8cb3)
let Color_DarkFont = UIColor(rgb: 0x3e3e3e)
let Color_LightFont = UIColor(rgb: 0x979797)


let mainURLForComments = "http://default-environment-7p45veqn6g.elasticbeanstalk.com/api/feed/comments?image_id="
let  tokenURLForComments = "&user_id=3&token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjMsImlzcyI6Imh0dHA6XC9cL2RlZmF1bHQtZW52aXJvbm1lbnQtN3A0NXZlcW42Zy5lbGFzdGljYmVhbnN0YWxrLmNvbVwvYXBpXC9hdXRoZW50aWNhdGUiLCJpYXQiOjE0OTc1NjMyNDYsImV4cCI6MTQ5ODc3Mjg0NiwibmJmIjoxNDk3NTYzMjQ2LCJqdGkiOiI4OWZkZGNkNTNlNDdhM2ZiYTY2ZDU0OGM1M2E5NjgwMCJ9.ZWjYFLnK4Q_hQjWOMrlqfy2NQL_wKbICHOXA2h8p0VY"

typealias DownloadComplete = () -> ()
