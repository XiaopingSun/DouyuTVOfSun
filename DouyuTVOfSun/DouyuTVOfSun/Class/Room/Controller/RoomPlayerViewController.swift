//
//  RoomPlayerViewController.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/12/12.
//  Copyright © 2018 WorkSpace_Sun. All rights reserved.
//

import UIKit
import PLPlayerKit
import SnapKit

private let isEnablePlayBackground: Bool = false

class RoomPlayerViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var urlString: String = ""
    
    private var isLive: Bool = false
    
    private let status: [String] = [
        "PLPlayerStatusUnknow",
        "PLPlayerStatusPreparing",
        "PLPlayerStatusReady",
        "PLPlayerStatusOpen",
        "PLPlayerStatusCaching",
        "PLPlayerStatusPlaying",
        "PLPlayerStatusPaused",
        "PLPlayerStatusStopped",
        "PLPlayerStatusError",
        "PLPlayerStateAutoReconnecting",
        "PLPlayerStatusCompleted"
    ]
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        activityIndicatorView.stopAnimating()
        return activityIndicatorView
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.default)
        progressView.progressTintColor = UIColor.orange
        progressView.trackTintColor = UIColor.lightGray
        progressView.progress = 0
        progressView.isHidden = true
        return progressView
    }()
    
    private lazy var eventButton: UIButton = {[weak self] in
        let eventButton = UIButton(type: .custom)
        eventButton.backgroundColor = UIColor.lightGray
        eventButton.setTitle("Event Action", for: .normal)
        eventButton.setTitleColor(UIColor.orange, for: .normal)
        eventButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        eventButton.addTarget(self, action: #selector(eventAction), for: .touchUpInside)
        eventButton.layer.masksToBounds = true
        eventButton.layer.cornerRadius = 5
        eventButton.isHidden = true
        return eventButton
    }()
    
    @available(iOS 10.0, *)
    private lazy var timer: Timer? = {[weak self] in
        let timer = Timer(timeInterval: 0.1, repeats: true, block: { (timer: Timer) in
            self!.progressView.progress = Float(CMTimeGetSeconds(self!.player.currentTime) / CMTimeGetSeconds(self!.player.totalDuration))
        })
        RunLoop.current.add(timer, forMode: .commonModes)
        return timer
    }()
    
    private lazy var cachePath: String = {
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString
        return docPath.appendingPathComponent("pili-videoCache") as String
    }()
    
    private lazy var player: PLPlayer = {[weak self] in
        let option = PLPlayerOption.default()
        option.setOptionValue(10, forKey: PLPlayerOptionKeyTimeoutIntervalForMediaPackets)
        option.setOptionValue(kPLLogDebug.rawValue, forKey: PLPlayerOptionKeyLogLevel)
        option.setOptionValue(false, forKey: PLPlayerOptionKeyVideoToolbox)
//        option.setOptionValue(cachePath, forKey: PLPlayerOptionKeyVideoCacheFolderPath)
        
        let player = PLPlayer(url: URL(string: urlString), option: option)!
        player.delegate = self
        player.delegateQueue = DispatchQueue.main
        player.isBackgroundPlayEnable = isEnablePlayBackground
        player.isAutoReconnectEnable = true
        player.playerView?.contentMode = .scaleAspectFit
        
        return player
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        player.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    deinit {
        player.stop()
        player.playerView?.removeFromSuperview()
        if isLive == false {
            if #available(iOS 10.0, *) {
                    timer?.invalidate()
                    timer = nil
            }
        }
    }
    
    @objc private func eventAction() {
        
    }
}

extension RoomPlayerViewController {
    private func setupUI() {
        view.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
        }
        
        view.addSubview(eventButton)
        eventButton.snp.makeConstraints { (make) in
            make.right.equalTo(progressView)
            make.bottom.equalTo(progressView.snp.top)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.bottom.equalTo(progressView.snp.top)
        }
        
        view.insertSubview(player.playerView!, at: 0)
        player.playerView!.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
}

extension RoomPlayerViewController: PLPlayerDelegate {
    func player(_ player: PLPlayer, statusDidChange state: PLPlayerStatus) {
        switch state {
        case .statusCaching:
            activityIndicatorView.startAnimating()
        default:
            activityIndicatorView.stopAnimating()
        }
        print("\(status[state.rawValue])")
    }
    func player(_ player: PLPlayer, stoppedWithError error: Error?) {
        activityIndicatorView.stopAnimating()
    }
    func player(_ player: PLPlayer, seekToCompleted isCompleted: Bool) {
        print("player seek to completed \(isCompleted)")
    }
    func player(_ player: PLPlayer, width: Int32, height: Int32) {
        print("width: %d  height:%d",width,height);
    }
    func player(_ player: PLPlayer, firstRender firstRenderType: PLPlayerFirstRenderType) {
        isLive = player.value(forKey: "isLive") as! Bool
        if firstRenderType == .video && isLive == false {
            if #available(iOS 10.0, *) {
                timer?.fire()
                progressView.isHidden = false
            }
        }
        eventButton.isHidden = false
    }
    func playerWillBeginBackgroundTask(_ player: PLPlayer) {
        if isEnablePlayBackground {
            player.enableRender = false
        } else {
            if isLive {
                player.stop()
            } else {
                player.pause()
            }
        }
    }
    func playerWillEndBackgroundTask(_ player: PLPlayer) {
        if isEnablePlayBackground {
            player.enableRender = true
        } else {
            if isLive {
                player.play()
            } else {
                player.resume()
            }
        }
    }
}
