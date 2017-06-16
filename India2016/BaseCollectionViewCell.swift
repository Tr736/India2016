//
//  BaseCollectionViewCell.swift
//  India2016
//
//  Created by Thomas Richardson on 15/06/2017.
//  Copyright © 2017 HiddenPixel. All rights reserved.
//

import UIKit
import SDWebImage
protocol BaseCollectionViewCellDelegate: class {
    func heartButtonPressed(_ sender: UIButton)
    func likeButtonPressed(_ sender: UIButton)
    func commentsButtonPressed(_ sender: UIButton)
}

class BaseCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var cellFooterView: CellFooterView!
    @IBOutlet var titleLabel: UILabel!
    
    
    weak var delegate:BaseCollectionViewCellDelegate?
    var buttonStates = [Bool]()
    var buttonSelected = false
    
    func configureCell(title: String, numberOfLikes : String, numberOfComment: String, imageURL : String){
        
        titleLabel.text = title.uppercased()
            commentsLabel.text = numberOfComment

        
        likesLabel.text = numberOfLikes
        imageView.sd_setImage(with: URL(string: imageURL))
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        CellFooter.drawCellFooter(frame: self.bounds, resizing: .aspectFill)
        
        
    }
    
    @IBAction func commentButtonPressed(_ sender: UIButton) {
        delegate?.commentsButtonPressed(sender)
    }
    
    @IBAction func heartButtonPressed(_ sender: UIButton) {
        delegate?.heartButtonPressed(sender)
    }
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
      
        sender.isSelected = !sender.isSelected
        sender.setImage(UIImage(named: "like_button_unsel"), for: .normal)

        sender.setImage(UIImage(named: "like_button_sel"), for: .selected)

        delegate?.likeButtonPressed(sender)
    }
}
