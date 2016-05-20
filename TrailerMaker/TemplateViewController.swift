//
//  TemplateViewController.swift
//  TrailerMaker
//
//  Created by CBLUE on 5/20/16.
//  Copyright © 2016 CBLUE. All rights reserved.
//

import UIKit

class TemplateViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var collectionView : UICollectionView!
    var trailerCoverPhotos : [UIImage]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let collectionCellWidth = (screenWidth - 40) / 2
        let collectionCellHeight = (collectionCellWidth / 1.4)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 15, bottom: 10, right: 15)
        layout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellHeight)

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        let nibName = UINib(nibName: "TemplateCollectionViewCell", bundle:NSBundle.mainBundle())
        collectionView.registerNib(nibName, forCellWithReuseIdentifier: "TemplateCell")
        collectionView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView)
        
        trailerCoverPhotos = [
            UIImage(named: "dark_knight")!,
            UIImage(named: "harry_potter")!,
            UIImage(named: "hunger_game")!,
            UIImage(named: "inception")!,
            UIImage(named: "twilight")!
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trailerCoverPhotos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TemplateCell", forIndexPath: indexPath) as! TemplateCollectionViewCell
        cell.backgroundColor = UIColor.redColor()
        cell.templateImageView.image = trailerCoverPhotos[indexPath.item]
        cell.templateImageView.contentMode = UIViewContentMode.ScaleAspectFill

        return cell
    }
}

