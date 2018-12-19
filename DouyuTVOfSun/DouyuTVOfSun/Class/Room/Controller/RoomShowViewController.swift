//
//  RoomShowViewController.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/12/12.
//  Copyright © 2018 WorkSpace_Sun. All rights reserved.
//

import UIKit
import PLMediaStreamingKit

class RoomShowViewController: UIViewController {
    
    private var pushUrl: String
    
    private var cameraPosition: AVCaptureDevice.Position
    private var isVideoToolBox: PLH264EncoderType
    private var sessionPreset: AVCaptureSession.Preset
    private var videoSize: CGSize
    private var frameRate: UInt
    private var bitrate: UInt
    private var keyframeInterval: UInt
    
    private lazy var startPushButton: UIButton = {[weak self] in
        let startPushButton = UIButton(type: .custom)
        startPushButton.setTitle("start", for: .normal)
        startPushButton.backgroundColor = UIColor.lightGray
        startPushButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        startPushButton.setTitleColor(UIColor.orange, for: .normal)
        startPushButton.setTitleColor(UIColor.orange, for: .selected)
        startPushButton.addTarget(self, action: #selector(startPushAction(sender:)), for: .touchUpInside)
        startPushButton.frame = CGRect(x: kScreenWidth - 80, y: kScreenHeight - 40, width: 80, height: 40)
        return startPushButton
    }()
    
    private lazy var closeButton: UIButton = {[weak self] in
        let closeButton: UIButton = UIButton(type: .custom)
        closeButton.frame = CGRect(x: 30, y: 50, width: 20, height: 20)
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return closeButton
    }()
    
    private lazy var streamingSession: PLMediaStreamingSession = {[weak self] in
        let videoCaptureConfiguration: PLVideoCaptureConfiguration = PLVideoCaptureConfiguration(videoFrameRate: frameRate, sessionPreset: sessionPreset.rawValue, previewMirrorFrontFacing: true, previewMirrorRearFacing: false, streamMirrorFrontFacing: false, streamMirrorRearFacing: false, cameraPosition: cameraPosition, videoOrientation: AVCaptureVideoOrientation.portrait)
        let videoStreamingConfiguration: PLVideoStreamingConfiguration = PLVideoStreamingConfiguration(videoSize: videoSize, expectedSourceVideoFrameRate: frameRate, videoMaxKeyframeInterval: keyframeInterval, averageVideoBitRate: bitrate, videoProfileLevel: AVVideoProfileLevelH264HighAutoLevel, videoEncoderType: isVideoToolBox)
        let streamingSession: PLMediaStreamingSession = PLMediaStreamingSession(videoCaptureConfiguration: videoCaptureConfiguration, audioCaptureConfiguration: PLAudioCaptureConfiguration.default(), videoStreamingConfiguration: videoStreamingConfiguration, audioStreamingConfiguration: PLAudioStreamingConfiguration.default(), stream: nil)

        streamingSession.setBeautifyModeOn(true)
        streamingSession.delegate = self
        streamingSession.previewView.frame = view.bounds

        return streamingSession
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        streamingSession.startCapture()
    }
    
    init(pushUrl: String, cameraPosition: AVCaptureDevice.Position, isVideoToolBox: PLH264EncoderType, sessionPreset: AVCaptureSession.Preset, videoSize: CGSize, frameRate: UInt, bitrate: UInt, keyframeInterval: UInt) {
        self.pushUrl = pushUrl
        self.cameraPosition = cameraPosition
        self.isVideoToolBox = isVideoToolBox
        self.sessionPreset = sessionPreset
        self.videoSize = videoSize
        self.frameRate = frameRate
        self.bitrate = bitrate
        self.keyframeInterval = keyframeInterval
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("RoomShowViewController dealloc")
    }
    
    @objc private func closeAction() {
        streamingSession.destroy()
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func startPushAction(sender: UIButton) {
        
        if streamingSession.isStreamingRunning == false {
            sender.isEnabled = false
            sender.setTitleColor(UIColor.gray, for: .normal)
            
            streamingSession.startStreaming(withPush: URL(string: pushUrl)) { (state: PLStreamStartStateFeedback) in
                DispatchQueue.main.async {
                    print("session start state \(state.rawValue)")
                    sender.isEnabled = true
                    sender.setTitleColor(UIColor.orange, for: .normal)
                    if state == PLStreamStartStateFeedback.success {
                        sender.setTitle("stop", for: .normal)
                    } else {
                        let alert = UIAlertView(title: "Warning", message: "Push Failed", delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                    }
                }
            }
        } else {
            streamingSession.stopStreaming()
            sender.setTitle("start", for: .normal)
        }
    }
}

extension RoomShowViewController {
    private func setupUI() {

        view.addSubview(closeButton)
        view.addSubview(startPushButton)
        view.insertSubview(streamingSession.previewView, at: 0)
    }
}

extension RoomShowViewController: PLMediaStreamingSessionDelegate {
    func mediaStreamingSession(_ session: PLMediaStreamingSession!, streamStateDidChange state: PLStreamState) {
        if PLStreamState.disconnected == state {
            startPushButton.setTitle("start", for: .normal)
        } else if PLStreamState.connected == state {
            startPushButton.setTitle("stop", for: .normal)
        }
    }
    func mediaStreamingSession(_ session: PLMediaStreamingSession!, streamStatusDidUpdate status: PLStreamStatus!) {

    }
    func mediaStreamingSession(_ session: PLMediaStreamingSession!, didDisconnectWithError error: Error!) {
        startPushButton.setTitle("start", for: .normal)
        let alert = UIAlertView(title: "Warning", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
}
