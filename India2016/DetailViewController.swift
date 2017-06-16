//
//  DetailViewController.swift
//  India2016
//
//  Created by Thomas Richardson on 15/06/2017.
//  Copyright © 2017 HiddenPixel. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {

    
    //MARK: TODO
    
    
    //MARK: @IBOUTLETS
    
    @IBOutlet weak var writeACommentTextField: UITextField!
    @IBOutlet weak var noCommentsLabel: UILabel!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint! // default is -150
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    //MARK: PROPERTIES
    
    private var _popupView : UIView!

    private let _parseData = ParseData()
    private var _resultsJsonArray = [ConvertJSONToDict]()

    
    private var _passedData : [String: String]!
    var kbHeight: CGFloat!

    var passedData : [String : String] {
        get {
           return _passedData
        }
        set {
            _passedData = newValue
        }
    }
    
    
    
    //MARK: INIT VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Comments".uppercased()
        collectionView.dataSource = self
        collectionView.delegate = self
        writeACommentTextField.delegate = self
        setupUI()
        if let imageID = _passedData["imageID"] {
            
            _parseData.fetchComments(imageID: imageID ) {
                self._resultsJsonArray = self._parseData.array
                
                if self._resultsJsonArray.count > 0 {
                    self.noCommentsLabel.isHidden = true
                } else {
                    self.noCommentsLabel.isHidden = false
                }
            }
        }
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)

    }
    

    //MARK: FUNCTIONS
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        if _popupView != nil {
            _popupView.removeFromSuperview()
        }
    }
    
    //MARK: CUSTOM FUNCTIONS
    
    func sendComment()  {
        var dictToPass = [String : String]()
        
        dictToPass["username"] = "Thomas"
        dictToPass["comment"] = writeACommentTextField.text
        writeACommentTextField.text = ""
        
        let objects =  ConvertJSONToDict(data: dictToPass)
        
        _resultsJsonArray.append(objects)
        noCommentsLabel.isHidden = true
        self.collectionView.reloadData()
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                kbHeight = keyboardSize.height
                self.animateTextField(up: true)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.animateTextField(up: false)
    }
    
    func animateTextField(up: Bool) {
        let movement = (up ? -kbHeight : kbHeight)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement!)
        })
    }
    func respondToSwipeGesture() {
        
        if (collectionView.contentOffset.y <= 0 ) {
            imageHeightConstraint.constant = -150
            // self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 1) {
                
                self.view.layoutIfNeeded()
            }
            
            self.view.setNeedsLayout()
        }


    }
    func setupUI() {
        self.imageView.sd_setImage(with: URL(string : _passedData["imageURL"] ?? ""))
        self.titleLabel.text = _passedData["username"] ?? "Name Goes Here"
        self.numberOfLikesLabel.text = _passedData["likes"] ?? "0"
    }
    
    func configureCell(cell: CommentsCollectionViewCell, indexPath : IndexPath) {
        
        cell.configureCell(title: _resultsJsonArray[indexPath.section].username, textBody: _resultsJsonArray[indexPath.section].comment)

    }
    
    //MARK: DELEGATES
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        sendComment()
        return false
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return _resultsJsonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CommentsCollectionViewCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let horizontalPadding: CGFloat = 16
        let verticalPadding : CGFloat = 16
        
        let text = _resultsJsonArray[indexPath.section].comment
        var boundingRect = NSString(string: text).boundingRect(with: CGSize(width: collectionView.bounds.width, height: 1000),
                                                                       options: .usesLineFragmentOrigin,
                                                                       attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20.0)],
                                                                       context: nil)
        // set a minimum height for the comments box
        if boundingRect.height < 100 {
            boundingRect.size = CGSize(width: collectionView.bounds.width, height: 75)
        }
        let size = CGSize(width: collectionView.bounds.width - (horizontalPadding * 2), height: ceil(boundingRect.height + (verticalPadding )))
        
        return size
    }
    

        
        
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if(scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0)
        {
    
            
        }
        else
        {
            imageHeightConstraint.constant = self.view.frame.height * 0.42
            // self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 1) {
                
                self.view.layoutIfNeeded()
            }
            
            self.view.setNeedsLayout()
        }

    }
    
    
    
    //MARK: CUSTOM DELEGATES
    
    
    //MARK: @IBACTIONS
    @IBAction func heartButtonPressed(_ sender: Any) {
        
        _popupView = Bundle.main.loadNibNamed("PopUpView", owner: nil, options: nil)?[0] as! UIView
        _popupView.frame = self.view.frame
        self.view.addSubview(_popupView)
        
    }
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true)
    }
    @IBAction func sendCommentButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        sendComment()
        
        // No mention on instructions to retain or upload data to server. This will be left out.
    }
}
