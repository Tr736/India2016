//
//  CommentsCollectionViewCell.swift
//  India2016
//
//  Created by Thomas Richardson on 16/06/2017.
//  Copyright © 2017 HiddenPixel. All rights reserved.
//

import UIKit

class CommentsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    func configureCell(title : String, textBody : String){
        
        
        titleLabel.text = title
        textView.text = textBody
    }
}
