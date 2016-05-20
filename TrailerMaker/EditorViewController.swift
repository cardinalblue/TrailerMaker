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
    lazy var recordButton = UIBarButtonItem()
    
    let session = AVCaptureSession.init()
    let preview = AVCaptureVideoPreviewLayer.init()
    let videoFileOutput = AVCaptureMovieFileOutput()
    
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
        timelineScrollView.backgroundColor = UIColor.wetAsphaltColor()
        timelineScrollView.snp_makeConstraints { make in
            make.leading.trailing.equalTo(self.view)
            make.bottom.equalTo(bottomToolBar.snp_top)
            make.height.equalTo(50)
        }
        
        let clips = ["12sec : Three People Fight", "8sec : Two People Kiss", "12sec : Two People Chase", "20sec : One Person Jump", "12sec : One Cat Miao"]
        
        var previousButton:UIButton = UIButton.init(frame: CGRectZero)
        
        for c:String in clips {
            
            let button = UIButton()
            button.setTitle(c, forState: UIControlState.Normal)
            button.sizeToFit()
            button.frame = CGRectMake(0, 0, CGRectGetWidth(button.frame) + 8, 34)
            button.backgroundColor = UIColor.turquoiseColor()
            button.addTarget(self, action: #selector(buttonClicked), forControlEvents: UIControlEvents.TouchUpInside)
            button.layer.cornerRadius = 3
            
            print("\(NSStringFromCGRect(button.frame))")
            
            if (previousButton.frame.origin.x == 0) {
                button.frame = CGRectMake(16, 8, CGRectGetWidth(button.frame), 34)
            }
            else {
                button.frame = CGRectMake(16 + CGRectGetMaxX(previousButton.frame), 8, CGRectGetWidth(button.frame) + 8, 34)
            }
            previousButton = button

            timelineScrollView.addSubview(button)
        }
        timelineScrollView.contentSize = CGSizeMake(CGRectGetMaxX(previousButton.frame) + 16, 50)
        
        
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
        
        recordButton.image =  UIImage.fontAwesomeIconWithName(.Circle, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        recordButton.tag = 0
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
        
        // Record Init
        
        session.sessionPreset = AVCaptureSessionPresetHigh
        
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        let input = try! AVCaptureDeviceInput.init(device: device)
        
        session.addInput(input)
        preview.session = session
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    internal func buttonClicked() {
        
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
        
        let doRecord = recordButton.tag == 0
        let stopRecord = recordButton.tag == 1
        
        if doRecord {
            recordButton.tag = 1
            
            // Preview
            
            preview.connection.videoOrientation = AVCaptureVideoOrientation.LandscapeRight
            
            preview.frame = recordView.bounds
            recordView.layer.addSublayer(preview)
            
            session.startRunning()
            
            // Record
            
            let recordingDelegate:AVCaptureFileOutputRecordingDelegate? = self
            
            session.addOutput(videoFileOutput)
            
            let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
            let filePath = documentsURL.URLByAppendingPathComponent("temp")
            
            videoFileOutput.startRecordingToOutputFileURL(filePath, recordingDelegate: recordingDelegate)
        }
        
        if (stopRecord) {
            recordButton.tag = 0
            
            preview.removeFromSuperlayer()
            
            videoFileOutput.stopRecording()
            session.removeOutput(videoFileOutput)
            
            session.stopRunning()
        }
        
        
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
}

// MARK: - UIImagePickerControllerDelegate
extension EditorViewController: UIImagePickerControllerDelegate {
}

// MARK: - UINavigationControllerDelegate
extension EditorViewController: UINavigationControllerDelegate {
}

extension EditorViewController: AVCaptureFileOutputRecordingDelegate {
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        print("didFinishRecordingToOutputFileAtURL \(outputFileURL)")
        return
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAtURL fileURL: NSURL!, fromConnections connections: [AnyObject]!) {
        print("didStartRecordingToOutputFileAtURL \(fileURL)")
        return
    }
}
