//
//  EditorViewController.swift
//  TrailerMaker
//
//  Created by CBLUE on 5/20/16.
//  Copyright © 2016 CBLUE. All rights reserved.
//

import UIKit
import SnapKit

class EditorViewController: UIViewController {

    lazy var recordView = UIView() // top left
    lazy var trailerView = UIView() // top right
    lazy var timelineScrollView = UIScrollView()
    lazy var bottomToolBar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.view.addSubview(bottomToolBar)
        bottomToolBar.snp_makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self.view)
            make.height.equalTo(44)
        }
        
        self.view.addSubview(timelineScrollView)
        timelineScrollView.snp_makeConstraints { make in
            make.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(bottomToolBar.snp_top)
            make.height.equalTo(44)
        }
        
        self.view.addSubview(recordView)
        recordView.snp_makeConstraints { make in
            make.leading.top.equalTo(self.view)
            make.bottom.equalTo(timelineScrollView.snp_top)
            make.width.equalTo(self.view).dividedBy(2)
        }
        
        self.view.addSubview(trailerView)
        trailerView.snp_makeConstraints { make in
            make.trailing.top.equalTo(self.view)
            make.bottom.equalTo(timelineScrollView.snp_top)
            make.width.equalTo(self.view).dividedBy(2)
        }

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
