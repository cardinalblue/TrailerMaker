//
//  EditorViewController.swift
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

class EditorViewController: UIViewController {

    lazy var recordView = UIView() // top left
    lazy var trailerView = UIView() // top right
    lazy var timelineScrollView = UIScrollView()
    lazy var bottomToolBar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // bottom bar
        self.view.addSubview(bottomToolBar)
        bottomToolBar.snp_makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self.view)
            make.height.equalTo(44)
        }
        
        // scroll view
        self.view.addSubview(timelineScrollView)
        timelineScrollView.backgroundColor = UIColor.silverColor()
        timelineScrollView.snp_makeConstraints { make in
            make.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(bottomToolBar.snp_top)
            make.height.equalTo(44)
        }
        
        // record view
        self.view.addSubview(recordView)
        recordView.backgroundColor = UIColor.blackColor()
        recordView.snp_makeConstraints { make in
            make.leading.top.equalTo(self.view)
            make.bottom.equalTo(timelineScrollView.snp_top)
            make.width.equalTo(self.view).dividedBy(2)
        }
        
        // trailer view
        self.view.addSubview(trailerView)
        trailerView.backgroundColor = UIColor.blackColor()
        trailerView.snp_makeConstraints { make in
            make.trailing.top.equalTo(self.view)
            make.bottom.equalTo(timelineScrollView.snp_top)
            make.width.equalTo(self.view).dividedBy(2)
        }

    
        // setup bottom bar and buttons
        let flexibleSpaceItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        let recordButton = UIBarButtonItem()
        recordButton.image =  UIImage.fontAwesomeIconWithName(.Circle, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        recordButton.tintColor = UIColor.alizarinColor()
        recordButton.target = self;
        recordButton.action = #selector(record)
        
        let backButton = UIBarButtonItem()
        backButton.image =  UIImage.fontAwesomeIconWithName(.ArrowLeft, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        backButton.tintColor = UIColor.peterRiverColor()
        
        let doneButton = UIBarButtonItem()
        doneButton.image =  UIImage.fontAwesomeIconWithName(.Check, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        doneButton.tintColor = UIColor.nephritisColor()
        
        bottomToolBar.configureFlatToolbarWithColor(UIColor.midnightBlueColor())
        bottomToolBar.items = [backButton, flexibleSpaceItem, recordButton, flexibleSpaceItem, doneButton]
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    internal func record() {
    
        playVideo()
        recordVideo()
    }
    
    internal func back() {
        
    }
    
    internal func done() {
        
    }
    
    func recordVideo() {
        let session = AVCaptureSession.init()
        session.sessionPreset = AVCaptureSessionPresetHigh
        
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        let input = try! AVCaptureDeviceInput.init(device: device)
        
        session.addInput(input)
        
        let preview = AVCaptureVideoPreviewLayer.init(session: session)
        preview.connection.videoOrientation = AVCaptureVideoOrientation.LandscapeLeft
        
        preview.frame = recordView.bounds
        recordView.layer.addSublayer(preview)
        
        session.startRunning()
    }
    
    private func playVideo() {
        guard let path = NSBundle.mainBundle().pathForResource("demo", ofType:"mp4") else {
            print("error")
            return
        }
        
        let player = AVPlayer(URL: NSURL(fileURLWithPath: path))

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.trailerView.bounds
        self.trailerView.layer.addSublayer(playerLayer)
        player.play()
    }
    
    func startCameraFromViewController(viewController: UIViewController, withDelegate delegate: protocol<UIImagePickerControllerDelegate, UINavigationControllerDelegate>) -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) == false {
            return false
        }
        
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .Camera
        cameraController.mediaTypes = [kUTTypeMovie as NSString as String]
        cameraController.allowsEditing = false
        cameraController.delegate = delegate
        
        presentViewController(cameraController, animated: true, completion: nil)
        return true
    }
    
    func startMediaBrowserFromViewController(viewController: UIViewController, usingDelegate delegate: protocol<UINavigationControllerDelegate, UIImagePickerControllerDelegate>) -> Bool {
        // 1
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) == false {
            return false
        }
        
        // 2
        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = .SavedPhotosAlbum
        mediaUI.mediaTypes = [kUTTypeMovie as NSString as String]
        mediaUI.allowsEditing = true
        mediaUI.delegate = delegate
        
        // 3
        presentViewController(mediaUI, animated: true, completion: nil)
        return true
    }
    
//    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
////        - (NSUInteger) supportedInterfaceOrientations
////            {
////                //Because your app is only landscape, your view controller for the view in your
////                // popover needs to support only landscape
////                return ;
////        }
//        return UIInterfaceOrientationMask.LandscapeLeft
//    }
    
}

// MARK: - UIImagePickerControllerDelegate
extension EditorViewController: UIImagePickerControllerDelegate {
}

// MARK: - UINavigationControllerDelegate
extension EditorViewController: UINavigationControllerDelegate {
}
