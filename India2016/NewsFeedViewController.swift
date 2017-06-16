//
//  NewsFeedViewController.swift
//  India2016
//
//  Created by Thomas Richardson on 15/06/2017.
//  Copyright © 2017 HiddenPixel. All rights reserved.
//

import UIKit

final class NewsFeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, BaseCollectionViewCellDelegate {

    //MARK: TODO
 
    
    //MARK: @IBOUTLETS
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: PROPERTIES
    
    private var _parseData = ParseData()
    private var _resultsJsonArray = [ConvertJSONToDict]()
    private var _popupView : UIView!
    private var _buttonStateArray = [Bool]()
    
    //MARK: INIT VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        _parseData.authenticate(){
            self._resultsJsonArray = self._parseData.array
            
           // print(self.resultsJsonArray.count)
             self.collectionView.reloadData()
            
            // setup button states for reusable cells default is 0
            for _ in 0...self._resultsJsonArray.count {
                self._buttonStateArray.append(false)
            }
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // reload collection view to set the like button states for each of the cells
        self.collectionView.reloadData()
    }
    

    
    //MARK: FUNCTIONS
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let destinationNavigationController = segue.destination as? UINavigationController {
            
            if let destination = destinationNavigationController.topViewController as? DetailViewController {
                
                if let data = sender as? [String : String] {
                   // print("Desitnation is DVC")
                    destination.passedData = data

                }

            }

        }

   
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if _popupView != nil {
            _popupView.removeFromSuperview()
        }
    }
    
    //MARK: CUSTOM FUNCTIONS
    
    func configureCollectionViewCell(cell : BaseCollectionViewCell , indexPath : IndexPath){
        
        // cell delegate allows for button usage within the cell
        if cell.delegate == nil {
            cell.delegate = self
        }
        cell.likeButton.tag = indexPath.section
        cell.commentsButton.tag = indexPath.section
        
        cell.configureCell(title: _resultsJsonArray[indexPath.section].username, numberOfLikes: _resultsJsonArray[indexPath.section].numberOfLikes, numberOfComment: _resultsJsonArray[indexPath.section].numberOfComments, imageURL: _resultsJsonArray[indexPath.section].imageURL)
        
        cell.likeButton.isSelected = _buttonStateArray[indexPath.section]

    }
    

  

    
    
    //MARK: DELEGATES
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return _resultsJsonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? BaseCollectionViewCell {
            configureCollectionViewCell(cell: cell, indexPath: indexPath)
            
            return cell
  
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0.0, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    self.performSegue(withIdentifier: "DetailVCSegue", sender: ["username" : _resultsJsonArray[indexPath.section].username ,
                                                                "likes" : _resultsJsonArray[indexPath.section].numberOfLikes,
                                                                "imageURL" : _resultsJsonArray[indexPath.section].imageURL,
                                                                "imageID" : _resultsJsonArray[indexPath.section].imageID ]
                          )
    }
    
    
    //MARK: CUSTOM DELEGATES
    
    func likeButtonPressed(_ sender: UIButton) {
        
   
        _buttonStateArray[sender.tag] = sender.isSelected

        if sender.isSelected {
            _resultsJsonArray[sender.tag].numberOfLikes = "\(Int(_resultsJsonArray[sender.tag].numberOfLikes)! + 1)"

        } else {
            _resultsJsonArray[sender.tag].numberOfLikes = "\(Int(_resultsJsonArray[sender.tag].numberOfLikes)! - 1)"

        }
        // reload items that are affected
        collectionView.reloadItems(at: [IndexPath(item: 0, section: sender.tag)])
   
    }
    
    
    
    func commentsButtonPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "DetailVCSegue", sender: ["username" : _resultsJsonArray[sender.tag].username ,
                                                                    "likes" : _resultsJsonArray[sender.tag].numberOfLikes,
                                                                    "imageURL" : _resultsJsonArray[sender.tag].imageURL,
                                                                    "imageID" : _resultsJsonArray[sender.tag].imageID ]
        )
    }
    
    func heartButtonPressed(_ sender: UIButton) {
        
        _popupView = Bundle.main.loadNibNamed("PopUpView", owner: nil, options: nil)?[0] as! UIView
        _popupView.frame = self.view.frame
        self.view.addSubview(_popupView)
    }
    
    
    //MARK: @IBACTIONS

 
}
