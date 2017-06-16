//
//  BaseTextField.swift
//  India2016
//
//  Created by Thomas Richardson on 15/06/2017.
//  Copyright © 2017 HiddenPixel. All rights reserved.
//

import UIKit

@IBDesignable class BaseTextField: UITextField {

  
    
    @IBInspectable var dropShadowColor : UIColor? {
        didSet{
            
            self.layer.shadowOpacity = 1.0;
            self.layer.shadowRadius = 0.0;
            self.layer.shadowColor =  dropShadowColor?.cgColor 
            self.layer.shadowOffset = CGSize(width: 0.0, height: 1)
        }
    }

}
