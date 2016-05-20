//
//  TemplateViewController.swift
//  TrailerMaker
//
//  Created by CBLUE on 5/20/16.
//  Copyright © 2016 CBLUE. All rights reserved.
//

import UIKit
import BLKFlexibleHeightBar

class TemplateViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    var collectionView : UICollectionView!
    var trailerCoverArray : [UIImage]!
    
    private var delegateSplitter: BLKDelegateSplitter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setNeedsStatusBarAppearanceUpdate()
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.height
        
        // Set up collection view
        let collectionCellWidth = (screenWidth - 40) / 2
        let collectionCellHeight = (collectionCellWidth / 1.4)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
        layout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellHeight)
        
        let collectionViewFrame = CGRectMake(0, 55, screenWidth, screenHeight - 55)
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentOffset = CGPointMake(20, 20)
        let nibName = UINib(nibName: "TemplateCollectionViewCell", bundle:NSBundle.mainBundle())
        collectionView.registerNib(nibName, forCellWithReuseIdentifier: "TemplateCell")
        collectionView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView)
        
        trailerCoverArray = [
            UIImage(named: "dark_knight")!,
            UIImage(named: "harry_potter")!,
            UIImage(named: "hunger_game")!,
            UIImage(named: "inception")!,
            UIImage(named: "twilight")!
        ]
        
        // create an instance of BLKFlexibleHeightBar with height of 100
        let titleBar = BLKFlexibleHeightBar()
        titleBar.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 120)
        titleBar.minimumBarHeight = 50.0
        titleBar.backgroundColor = UIColor.init(red: 0.56, green: 0.25, blue: 0.23, alpha: 1)
        self.view.addSubview(titleBar)
        
        // Setting delegate splitter
        let fbBehaviorDefiner = FacebookStyleBarBehaviorDefiner()

        // Snap to the max height (progress == 0.0) or min height (progress == 1.0) depending on whichever
        // is closer.
        fbBehaviorDefiner.addSnappingPositionProgress(0.0, forProgressRangeStart: 0.0, end: 0.5)
        fbBehaviorDefiner.addSnappingPositionProgress(1.0, forProgressRangeStart: 0.5, end: 1.0)
//        fbBehaviorDefiner.thresholdNegativeDirection = 140.0
        fbBehaviorDefiner.snappingEnabled = true
        
        titleBar.behaviorDefiner = fbBehaviorDefiner

        titleBar.behaviorDefiner.snappingEnabled = true
        
        self.delegateSplitter = BLKDelegateSplitter(firstDelegate: titleBar.behaviorDefiner, secondDelegate: self)
        self.collectionView.delegate = self.delegateSplitter
        
        
        // Create a subview and add it to the title bar in order to create the smootly
        // shrinks and fade away effect
        let label = UILabel()
        label.text = "TrendyStartup.io"
        label.font = UIFont.systemFontOfSize(25.0)
        label.textColor = UIColor.whiteColor()
        label.sizeToFit()
        titleBar.addSubview(label)
        titleBar.contentMode = UIViewContentMode.Center
        let initialLayoutAttributes = BLKFlexibleHeightBarSubviewLayoutAttributes()
        initialLayoutAttributes.size = label.frame.size
        initialLayoutAttributes.center = CGPointMake(CGRectGetMidX(titleBar.frame), CGRectGetMidY(titleBar.frame));

        
        let finalLayoutAttributes: BLKFlexibleHeightBarSubviewLayoutAttributes = BLKFlexibleHeightBarSubviewLayoutAttributes(existingLayoutAttributes: initialLayoutAttributes)
        
        finalLayoutAttributes.alpha = 0.0
        let translation: CGAffineTransform = CGAffineTransformMakeTranslation(0.0, -30.0)
        let scale: CGAffineTransform = CGAffineTransformMakeScale(0.2, 0.2)
        finalLayoutAttributes.transform = CGAffineTransformConcat(scale, translation)
        
        
        // What the title bar looks like at its max height
//        label.addLayoutAttributes(initialLayoutAttributes, forProgress: 1.0)
        
        // What the title bar looks like at its min height
//        label.addLayoutAttributes(finalLayoutAttributes, forProgress: 0.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trailerCoverArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TemplateCell", forIndexPath: indexPath) as! TemplateCollectionViewCell
        cell.backgroundColor = UIColor.redColor()
        cell.templateImageView.image = trailerCoverArray[indexPath.item]
        cell.templateImageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedTrailerName = trailerCoverArray[indexPath.item]
        
        let editorVC = EditorViewController()
        
        
        
        self.navigationController?.pushViewController(editorVC, animated: true)
    }
}


//Required, to make objc code work with swift
extension BLKDelegateSplitter: UICollectionViewDelegate{
    
}

