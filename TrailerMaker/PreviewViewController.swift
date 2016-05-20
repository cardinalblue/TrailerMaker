//
//  PreviewViewController.swift
//  TrailerMaker
//
//  Created by CBLUE on 5/20/16.
//  Copyright © 2016 CBLUE. All rights reserved.
//

import UIKit
import SnapKit
import AVKit
import AVFoundation
import FlatUIKit
import FontAwesome_swift
import MediaPlayer
import MobileCoreServices

class PreviewViewController: UIViewController {

    lazy var recordView = UIView() // top left
    lazy var trailerView = UIView() // top right
    lazy var bottomToolBar = UIToolbar()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // bottom bar
        self.view.addSubview(bottomToolBar)
        bottomToolBar.snp_makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self.view)
            make.height.equalTo(44)
        }
        
        // record view
        self.view.addSubview(recordView)
        recordView.backgroundColor = UIColor.blackColor()
        recordView.snp_makeConstraints { make in
            make.leading.top.equalTo(self.view)
            make.bottom.equalTo(bottomToolBar.snp_top)
            make.width.equalTo(self.view).dividedBy(2)
        }
        
        // trailer view
        self.view.addSubview(trailerView)
        trailerView.backgroundColor = UIColor.blackColor()
        trailerView.snp_makeConstraints { make in
            make.trailing.top.equalTo(self.view)
            make.bottom.equalTo(bottomToolBar.snp_top)
            make.width.equalTo(self.view).dividedBy(2)
        }

        // setup bottom bar and buttons
        let flexibleSpaceItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        let playButton = UIBarButtonItem()

        playButton.image =  UIImage.fontAwesomeIconWithName(.Play, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        playButton.tag = 0
        playButton.tintColor = UIColor.alizarinColor()
        playButton.target = self;
        playButton.action = #selector(play)
        
        let backButton = UIBarButtonItem()
        backButton.image =  UIImage.fontAwesomeIconWithName(.ArrowLeft, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        backButton.tintColor = UIColor.peterRiverColor()
        backButton.action = #selector(back)
        backButton.target = self
        
        let shareButton = UIBarButtonItem()
        shareButton.image =  UIImage.fontAwesomeIconWithName(.Share, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        shareButton.tintColor = UIColor.nephritisColor()
        
        bottomToolBar.configureFlatToolbarWithColor(UIColor.midnightBlueColor())
        bottomToolBar.items = [backButton, flexibleSpaceItem, playButton, flexibleSpaceItem, shareButton]
    }
    
    internal func play() {
        
    }
    
    internal func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
