
//
//  LiveViewController.swift
//  DouyuTVOfSun
//
//  Created by WorkSpace_Sun on 2018/12/13.
//  Copyright © 2018 WorkSpace_Sun. All rights reserved.
//

import UIKit
import PLMediaStreamingKit

private let cellIdentifier: String = "cellIdentifier"

class LiveViewController: UIViewController {

    @IBOutlet weak var pushUrlTF: UITextField!
    @IBOutlet weak var pushButton: UIButton!
    @IBOutlet weak var cemaraPositionSC: UISegmentedControl!
    @IBOutlet weak var videoToolBoxSC: UISegmentedControl!
    @IBOutlet weak var sessionPresetButton: UIButton!
    @IBOutlet weak var videoSizeButton: UIButton!
    @IBOutlet weak var frameRateSC: UISegmentedControl!
    @IBOutlet weak var bitrateTF: UITextField!
    @IBOutlet weak var GopSC: UISegmentedControl!
    
    private var isSessionPresetSelected: Bool = true
    
    private var sessionPresetShow: [String] = [
        "AVCaptureSessionPreset352x288",
        "AVCaptureSessionPreset640x480",
        "AVCaptureSessionPreset1280x720",
        "AVCaptureSessionPreset1920x1080",
        "AVCaptureSessionPresetLow",
        "AVCaptureSessionPresetMedium",
        "AVCaptureSessionPresetHigh",
        "AVCaptureSessionPresetPhoto",
        "AVCaptureSessionPresetInputPriority",
        "AVCaptureSessionPresetiFrame960x540",
        "AVCaptureSessionPresetiFrame1280x720",
    ]
    
    private let sessionPresetList: [AVCaptureSession.Preset] = [
        AVCaptureSession.Preset.cif352x288,
        AVCaptureSession.Preset.vga640x480,
        AVCaptureSession.Preset.hd1280x720,
        AVCaptureSession.Preset.hd1920x1080,
        AVCaptureSession.Preset.low,
        AVCaptureSession.Preset.medium,
        AVCaptureSession.Preset.high,
        AVCaptureSession.Preset.photo,
        AVCaptureSession.Preset.inputPriority,
        AVCaptureSession.Preset.iFrame960x540,
        AVCaptureSession.Preset.iFrame1280x720,
    ]
    
    private let videoSizeShow: [String] = [
        "368x640",
        "540x960",
        "720x1280",
        "1080x1920"
    ]
    
    private let videoSizeList: [CGSize] = [
        CGSize(width: 368, height: 640),
        CGSize(width: 540, height: 960),
        CGSize(width: 720, height: 1280),
        CGSize(width: 1080, height: 1920)
    ]
    
    private let frameRateList: [UInt] = [5, 10, 15, 20, 24, 30]
    
    private var cameraPosition: AVCaptureDevice.Position {
        return cemaraPositionSC.selectedSegmentIndex == 0 ? .front : .back
    }
    
    private var isVideoToolBox: PLH264EncoderType {
        return videoToolBoxSC.selectedSegmentIndex == 0 ? .videoToolbox : .avFoundation
    }
    
    private var sessionPreset: AVCaptureSession.Preset {
        let index = (sessionPresetShow as NSArray).index(of: sessionPresetButton.titleLabel?.text! as Any)
        return sessionPresetList[index]
    }
    
    private var videoSize: CGSize {
        let index = (videoSizeShow as NSArray).index(of: videoSizeButton.titleLabel?.text! as Any)
        return videoSizeList[index]
    }
    
    private var frameRate: UInt {
        return frameRateList[frameRateSC.selectedSegmentIndex]
    }
    
    private var bitrate: UInt {
        return (UInt(bitrateTF.text ?? "1000") ?? 1000) * 1024
    }
    
    private var keyframeInterval: UInt {
        return UInt(GopSC.selectedSegmentIndex.advanced(by: 1)) * frameRate
    }
    
    private lazy var tableView: UITableView = {[weak self] in
        let tableView: UITableView = UITableView(frame: CGRect(x: 60, y: 240, width: kScreenWidth - 120, height: 44 * 4), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.alpha = 0.01
        tableView.isHidden = true
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 5
        return tableView
    }()
    
    override func viewDidLoad() {

        title = "直播"
        let image: UIImage = UIImage(named: "Image_scan")!.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: #selector(scanAction))
        
        // 默认推流地址
        pushUrlTF.text = "rtmp://pili-publish.live.sunxp.qiniuts.com/pursue-live/Sun"
        
        view.addSubview(tableView)
    }
    
    @IBAction func sessionPresetAction(_ sender: Any) {
        isSessionPresetSelected = true
        tableView.reloadData()
        UIView.animate(withDuration: 0.2) {
            self.tableView.alpha = 1.0
            self.tableView.isHidden = false
        }
    }
    
    @IBAction func videoSizeAction(_ sender: Any) {
        isSessionPresetSelected = false
        tableView.reloadData()
        UIView.animate(withDuration: 0.2) {
            self.tableView.alpha = 1.0
            self.tableView.isHidden = false
        }
    }
    
    @IBAction func startPush(_ sender: Any) {
        guard (pushUrlTF.text != "") else {
            let alert = UIAlertView(title: "Warning", message: "push url cannot be nil", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return
        }
        let pushUrl = (pushUrlTF.text?.replacingOccurrences(of: " ", with: ""))!
        let showViewController = RoomShowViewController(pushUrl:pushUrl, cameraPosition: cameraPosition, isVideoToolBox: isVideoToolBox, sessionPreset: sessionPreset, videoSize: videoSize, frameRate: frameRate, bitrate: bitrate, keyframeInterval: keyframeInterval)
        present(showViewController, animated: true, completion: nil)
    }
    
    @objc private func scanAction() {
        let scanCodeViewController: ScanCodeViewController = ScanCodeViewController()
        scanCodeViewController.delegate = self
        present(scanCodeViewController, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if tableView.isHidden == false {
            UIView.animate(withDuration: 0.2) {
                self.tableView.alpha = 0.01
                self.tableView.isHidden = true
            }
        }
        view.endEditing(true)
    }
}

extension LiveViewController: ScanCodeViewControllerDelegate {
    func scanCodeViewController(_ viewController: ScanCodeViewController, didCompleteScanning codeString: String?) {
        guard let codeString = codeString else {
            let alert = UIAlertView(title: "Warning", message: "scan code is nil", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return
        }
        pushUrlTF.text = codeString
    }
}

extension LiveViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSessionPresetSelected == true {
            return 11
        } else {
            return 4
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.lightGray
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        if isSessionPresetSelected == true {
            cell.textLabel?.text = sessionPresetShow[indexPath.row]
        } else {
            cell.textLabel?.text = videoSizeShow[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSessionPresetSelected == true {
            sessionPresetButton.setTitle(sessionPresetShow[indexPath.row], for: .normal)
        } else {
            videoSizeButton.setTitle(videoSizeShow[indexPath.row], for: .normal)
        }
        UIView.animate(withDuration: 0.2) {
            self.tableView.alpha = 0.01
            self.tableView.isHidden = true
        }
    }
}


